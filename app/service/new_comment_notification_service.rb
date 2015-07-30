class NewCommentNotificationService
  def initialize(comment:)
    @comment = comment
    @issue = comment.issue
  end

  def call
    participants = @issue.participants.flatten.uniq
    recipients = participants - [@comment.user]

    recipients.each do |recipient|
      IssueMailer.new_comment_notification(comment: @comment, recipient: recipient).deliver_later
    end
  end
end
