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

class Issue < ActiveRecord::Base
  enum status: [:open, :closed]

  belongs_to :user
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :status, presence: true, inclusion: { in: statuses }, allow_blank: true
  validates :user, presence: true
  validates_associated :user
end
