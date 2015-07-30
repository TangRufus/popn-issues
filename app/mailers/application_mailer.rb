class ApplicationMailer < ActionMailer::Base
  helper ApplicationHelper

  default from:  '"Popn Issues" <popn-issues@pinot.hk>'
  layout 'mailer'
end
