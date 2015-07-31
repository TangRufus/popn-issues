class NewCommentNotificationService
  def initialize(comment:)
    @comment = comment
    @issue = comment.issue
  end

  def call
    recipients.each do |recipient|
      IssueMailer.new_comment_notification(comment: @comment, recipient: recipient).deliver_later
    end
  end

  private

  def recipients
    @issue.participants.flatten.uniq - [@comment.user]
  end
end
