class NewIssueNotificationService
  def initialize(issue:)
    @issue = issue
  end

  def call
    recipients.each do |recipient|
      IssueMailer.new_issue_notification(recipient: recipient, issue: @issue).deliver_later
    end
  end

  private

  def recipients
    subscribers = User.subscribed_to_new_issues + @issue.participants
    subscribers.flatten.uniq - [@issue.user]
  end
end
