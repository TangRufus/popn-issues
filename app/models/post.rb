# == Schema Information
#
# Table name: posts
#
#  id              :integer          not null, primary key
#  title           :text             not null
#  published_at    :datetime         not null
#  modified_at     :datetime         not null
#  link            :string           not null
#  excerpt         :text
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  purged_at       :datetime
#  host            :string           not null
#  posted_to_fb_at :datetime
#
# Indexes
#
#  index_posts_on_host          (host)
#  index_posts_on_link          (link) UNIQUE
#  index_posts_on_modified_at   (modified_at)
#  index_posts_on_published_at  (published_at)
#

class Post < ActiveRecord::Base
  scope :posted_to_facebook, -> {where.not(posted_to_fb_at: nil).order(posted_to_fb_at: :asc) }

  has_many :taggings, dependent: :destroy
  has_many :terms, through: :taggings

  after_commit :purge_from_cloudflare, on: [:create, :update]
  after_commit :schedule_facebook_posting, on: [:create]

  def self.last_posted_to_fb_at
    return 30.years.ago unless posted_to_facebook
    posted_to_facebook.last.posted_to_fb_at
  end

  def purge_urls
    urls = [link, "#{link}?fb_ref=Default"]
    urls << [next_post.link, "#{next_post.link}?fb_ref=Default"] if next_post
    urls << [prev_post.link, "#{prev_post.link}?fb_ref=Default"] if prev_post
    urls
  end

  def next_post
    Post.where(host: host).where("published_at > ?", published_at).order(published_at: :desc).first
  end

  def prev_post
    Post.where(host: host).where("published_at < ?", published_at).order(published_at: :asc).last
  end

  def purge_from_cloudflare
    return unless should_purge?
    PurgeCloudflareJob.perform_later(self)
    terms.each do |term|
      PurgeCloudflareJob.perform_later(term)
    end
  end

  def should_purge?
    purged_at.nil? || purged_at < published_at || purged_at < modified_at
  end

  def should_post_to_facebook?
    posted_to_fb_at.nil?
  end

  def schedule_facebook_posting
    return unless should_post_to_facebook?
    KpopnPostToFacebookJob.perform_later(self) if host == 'kpopn.com'
    ApopnPostToFacebookJob.perform_later(self) if host == 'apopn.com'
  end
end
