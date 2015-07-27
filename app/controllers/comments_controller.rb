class CommentsController < ApplicationController
  before_action :create_new_form

  def create
    @comment_form.submit(comment_params)

    respond_to do |format|
      if @comment_form.save
        flash[:success] = 'Comment added successfully'
      else
        flash[:error] = @comment_form.errors.full_messages.uniq.join('. ')
      end
      format.html { redirect_to @issue }
    end
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
