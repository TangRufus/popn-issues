class WikisController < ApplicationController
  before_action :set_wiki, only: [:show, :edit, :update]
  before_action :create_form, only: [:new, :create, :edit, :update]


  def index
    @wikis = Wiki.all.order(updated_at: :desc)
  end

  def new
  end

  def create
    @wiki_form.submit(issue_params)
    @wiki_form.user = current_user

    respond_to do |format|
      if @wiki_form.save
        flash[:success] = 'Wiki created successfully'
        format.html { redirect_to @wiki_form }
      else
        flash[:error] = @wiki_form.errors.full_messages.uniq.join('. ')
        format.html { render :new }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @wiki_form.submit(issue_params)
    @wiki_form.user = current_user

    respond_to do |format|
      if @wiki_form.save
        flash[:success] = 'Wiki updated successfully'
        format.html { redirect_to @wiki_form }
      else
        flash[:error] = @wiki_form.errors.full_messages.uniq.join('. ')
        format.html { render :new }
      end
    end
  end

  private

  def set_wiki
    @wiki = Wiki.find(params[:id])
  end

  def create_form
    @wiki ||= Wiki.new(user: current_user)
    @wiki_form = WikiForm.new(@wiki)
  end

  def issue_params
    params.require(:wiki).permit(:title, :body)
  end
end
