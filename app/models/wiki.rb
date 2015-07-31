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

class Wiki < ActiveRecord::Base
  belongs_to :user

  auto_strip_attributes :title

  validates :title, presence: true, uniqueness: true
  validates :body, presence: true
  validates :user, presence: true
  validates_associated :user
end
