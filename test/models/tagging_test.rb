# == Schema Information
#
# Table name: taggings
#
#  id         :integer          not null, primary key
#  term_id    :integer          not null
#  post_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_taggings_on_post_id  (post_id)
#  index_taggings_on_term_id  (term_id)
#

require 'test_helper'

class TaggingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
