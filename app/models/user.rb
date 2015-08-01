# == Schema Information
#
# Table name: users
#
#  id                      :integer          not null, primary key
#  email                   :string           default(""), not null
#  encrypted_password      :string           default(""), not null
#  reset_password_token    :string
#  reset_password_sent_at  :datetime
#  remember_created_at     :datetime
#  sign_in_count           :integer          default(0), not null
#  current_sign_in_at      :datetime
#  last_sign_in_at         :datetime
#  current_sign_in_ip      :inet
#  last_sign_in_ip         :inet
#  confirmation_token      :string
#  confirmed_at            :datetime
#  confirmation_sent_at    :datetime
#  unconfirmed_email       :string
#  failed_attempts         :integer          default(0), not null
#  unlock_token            :string
#  locked_at               :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  username                :string
#  subscribe_new_issues    :boolean          default(TRUE), not null
#  subscribe_urgent_issues :boolean          default(FALSE), not null
#
# Indexes
#
#  index_users_on_confirmation_token       (confirmation_token) UNIQUE
#  index_users_on_email                    (email) UNIQUE
#  index_users_on_reset_password_token     (reset_password_token) UNIQUE
#  index_users_on_subscribe_new_issues     (subscribe_new_issues)
#  index_users_on_subscribe_urgent_issues  (subscribe_urgent_issues)
#  index_users_on_unlock_token             (unlock_token) UNIQUE
#  index_users_on_username                 (username) UNIQUE
#

class User < ActiveRecord::Base
  USERNAME_PATTERN = /\A[a-z0-9]+\z/
  USERNAME_AT_MENTION_PATTERN = /[a-z0-9]+/

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :lockable, :timeoutable, :async

  attr_accessor :login

  has_many :issues
  has_many :comments

  auto_strip_attributes :username, delete_whitespaces: true

  validates :username, format: { with: USERNAME_PATTERN }
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validate :allowed_email_domains

  scope :subscribed_to_new_issues, -> { where(subscribe_new_issues: true) }
  scope :subscribed_to_urgent_issues, -> { where(subscribe_urgent_issues: true) }

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions.to_hash).find_by(['username = :value OR email = :value', { value: login.downcase }])
    else
      find_by(conditions.to_hash)
    end
  end

  def self.all_ordered_by_domain
    all.sort_by { |u| [u.email.split('@').last, u.sign_in_count] }.reverse
  end

  def allowed_email_domains
    return if email.end_with?('@pinot.hk', '@kpopn.com', '@apopn.com', '@po.pn', '@homecafe.com.tw')
    errors.add(:email, 'domain not allowed')
  end
end
