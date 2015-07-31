class CommentsController < ApplicationController
  before_action :create_new_form

  def create
    @comment_form.submit(comment_params)

    if @comment_form.save
      if @issue.urgent?
        UrgentIssueNotificationService.new(issue: @issue).call
      else
        NewCommentNotificationService.new(comment: @comment_form.model).call
      end
      flash[:success] = 'Comment added successfully'
    else
      flash[:error] = @comment_form.errors.full_messages.uniq.join('. ')
    end
    redirect_to @issue
  end

  private

  def create_new_form
    @issue = Issue.find(params[:id])
    comment = Comment.new(user: current_user, issue: @issue)
    @comment_form = CommentForm.new(comment)
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
