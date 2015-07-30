class IssueMailer < ApplicationMailer
  def new_issue_notification(recipient:, issue:)
    @recipient = recipient
    @issue = issue
    @comment = issue.comments.first
    @issue_owner = issue.user

    from = "\"#{@issue_owner.username}\" <#{@issue_owner.email}>"
    to = "\"#{@recipient.username}\" <#{@recipient.email}>"
    subject = "[popn-issues] #{@issue.title} (##{@issue.id})"

    mail(from: from, to: to, subject: subject)
  end
end
