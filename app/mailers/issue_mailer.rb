class IssueMailer < ApplicationMailer
  helper MarkdownHelper

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

  def new_comment_notification(recipient:, comment:)
    @recipient = recipient
    @issue = comment.issue
    @comment = comment
    @comment_owner = @comment.user

    from = "\"#{@comment_owner.username}\" <#{@comment_owner.email}>"
    to = "\"#{@recipient.username}\" <#{@recipient.email}>"
    subject = "[popn-issues] #{@issue.title} (##{@issue.id})"

    mail(from: from, to: to, subject: subject)
  end

  def urgent_issue_notification(recipient:, issue:)
    @recipient = recipient
    @issue = issue
    @comments = issue.comments

    to = "\"#{@recipient.username}\" <#{@recipient.email}>"
    subject = "Urgent [popn-issues] #{@issue.title} (##{@issue.id})"

    mail(to: to, subject: subject)
  end
end
