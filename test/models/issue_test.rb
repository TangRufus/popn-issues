# == Schema Information
#
# Table name: issues
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  status     :integer          default(0), not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_issues_on_status   (status)
#  index_issues_on_title    (title) UNIQUE
#  index_issues_on_user_id  (user_id)
#

require 'test_helper'

class IssueTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
