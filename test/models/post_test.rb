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

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
