class UrgentIssueNotificationService
  def initialize(issue:)
    @issue = issue
  end

  def call
    recipients.each do |recipient|
      IssueMailer.urgent_issue_notification(issue: @issue, recipient: recipient).deliver_later
    end
  end

  private

  def recipients
    subscribers = User.subscribed_to_urgent_issues
    participants = @issue.participants.flatten.uniq
    recipients = subscribers + participants
    recipients.flatten.uniq
  end
end
