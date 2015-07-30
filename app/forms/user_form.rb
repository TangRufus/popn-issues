class UserForm < ActionForm::Base
  self.main_model = :user

  attribute :subscribe_new_issue
  validates :subscribe_new_issue, inclusion: { in: [true, false] }
end
