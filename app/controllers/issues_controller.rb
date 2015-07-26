class IssuesController < ApplicationController
  before_action :create_new_form, only: [:new, :create]

  def index
  end

  def new
  end

  def create
    @issue_form.submit(issue_params)
    @issue_form.comments.first.user = current_user
    @issue_form.comments.first.issue = @issue_form.model

    respond_to do |format|
      if @issue_form.save
        flash[:success] = 'Deal sent successfully'
        format.html { redirect_to @issue_form }
      else
        flash[:error] = @issue_form.errors.full_messages.uniq.join('. ')
        format.html { render :new }
      end
    end
  end

  def show
    @issue = Issue.find(params[:id])
  end

  private

  def create_new_form
    issue = Issue.new(user: current_user)
    @issue_form = IssueForm.new(issue)
  end

  def issue_params
    params.require(:issue).permit(:title, comments_attributes: [:body])
  end
end
