# == Schema Information
#
# Table name: posts
#
#  id           :integer          not null, primary key
#  title        :text             not null
#  published_at :datetime         not null
#  modified_at  :datetime         not null
#  link         :string           not null
#  excerpt      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  purged_at    :datetime
#  host         :string           not null
#
# Indexes
#
#  index_posts_on_host          (host)
#  index_posts_on_link          (link) UNIQUE
#  index_posts_on_modified_at   (modified_at)
#  index_posts_on_published_at  (published_at)
#

class Post < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :terms, through: :taggings

  after_commit :purge_from_cloudflare, on: [:create, :update]

  def purge_urls
    urls = [link]
    urls << next_post.link if next_post
    urls << prev_post.link if prev_post
  end

  def next_post
    Post.where(host: host).where("published_at > ?", published_at).order(published_at: :desc).first
  end

  def prev_post
    Post.where(host: host).where("published_at < ?", published_at).order(published_at: :asc).last
  end

  def purge_from_cloudflare
    PurgeCloudflareJob.perform_later(self)
  end
end
