# == Schema Information
#
# Table name: wikis
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  body       :text             not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_wikis_on_title    (title) UNIQUE
#  index_wikis_on_user_id  (user_id)
#

require 'test_helper'

class WikiTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
