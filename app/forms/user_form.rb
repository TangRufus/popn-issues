class UserForm < ActionForm::Base
  self.main_model = :user

  attribute :subscribe_new_issues, :subscribe_urgent_issues
  validates :subscribe_new_issues, inclusion: { in: [true, false] }
  validates :subscribe_urgent_issues, inclusion: { in: [true, false] }
end
