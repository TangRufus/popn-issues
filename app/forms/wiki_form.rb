class WikiForm < ActionForm::Base
  self.main_model = :wiki

  attribute :title, :body, required: true
  attribute :user
end
