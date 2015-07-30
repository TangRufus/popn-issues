class NewIssueNotificationService
  def initialize(issue:)
    @issue = issue
  end

  def call
    subscribers = User.subscribed_to_new_issues + @issue.participants
    recipients = subscribers.flatten.uniq.reject { |subscriber| subscriber == @issue.user }

    recipients.each do |recipient|
      IssueMailer.new_issue_notification(issue: @issue, recipient: recipient).deliver_later
    end
  end
end
