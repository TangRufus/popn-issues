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
#
# Indexes
#
#  index_posts_on_link          (link) UNIQUE
#  index_posts_on_modified_at   (modified_at)
#  index_posts_on_published_at  (published_at)
#

class Post < ActiveRecord::Base
  has_many :taggings, dependent: :destroy
  has_many :terms, through: :taggings

  def next
    Post.where("published_at > ?", published_at).first
  end

  def prev
    Post.where("published_at < ?", published_at).last
  end
end
