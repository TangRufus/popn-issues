class UsersController < ApplicationController
  before_action :create_edit_form, only: [:edit, :update]

  def index
    @users = User.all_ordered_by_domain
  end

  def edit
  end

  def update
    @user_form.submit(user_params)

    if @user_form.save
      flash[:success] = 'Settings updated successfully'
      redirect_to edit_user_path(@user_form)
    else
      flash[:error] = @user_form.errors.full_messages.uniq.join('. ')
      render :edit
    end
  end

  private

  def create_edit_form
    @user_form = UserForm.new(current_user)
  end

  def user_params
    params.require(:user).permit(:subscribe_new_issue)
  end
end
