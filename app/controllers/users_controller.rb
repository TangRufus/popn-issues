class UsersController < ApplicationController
  def index
    @users = User.all_ordered_by_domain
  end
end
