class IssuesController < ApplicationController
  before_action :create_new_form, only: [:new, :create]
  before_action :set_counts, only: [:index, :new, :show]

  def index
    case params[:scope]
    when 'all'
      @issues = Issue.all.includes(comments: :user).order(updated_at: :desc)
    when 'urgent'
      @issues = Issue.urgent.includes(comments: :user).order(updated_at: :desc)
    when 'open'
      @issues = Issue.open.includes(comments: :user).order(updated_at: :desc)
    when 'closed'
      @issues = Issue.closed.includes(comments: :user).order(updated_at: :desc)
    else
      @issues = Issue.open.includes(comments: :user).order(updated_at: :desc)
    end
  end

  def new
  end

  def create
    @issue_form.submit(issue_params)
    @issue_form.comments.first.user = current_user
    @issue_form.comments.first.issue = @issue_form.model

    respond_to do |format|
      if @issue_form.save
        flash[:success] = 'Issue created successfully'
        format.html { redirect_to @issue_form }
      else
        flash[:error] = @issue_form.errors.full_messages.uniq.join('. ')
        format.html { render :new }
      end
    end
  end

  def show
    @issue = Issue.all.includes(comments: :user).where(id: params[:id]).first
  end

  def change_status
    @issue = Issue.find(params[:id])
    if @issue.update(status: issue_status_params)
      flash[:success] = 'Issue updated'
    else
      flash[:error] = @issue.errors.full_messages.uniq.join('. ')
    end
    redirect_to @issue
  end

  private

  def create_new_form
    issue = Issue.new(user: current_user)
    @issue_form = IssueForm.new(issue)
  end

  def issue_params
    params.require(:issue).permit(:title, comments_attributes: [:body])
  end

  def issue_status_params
    params.require(:status)
  end

  def set_counts
    @all_count = Issue.all.size
    @urgent_count = Issue.urgent.size
    @open_count = Issue.open.size
    @closed_count = Issue.closed.size
  end
end
