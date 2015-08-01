class ApplicationController < ActionController::Base
  include RedirectToCurrentPageAfterSignIn

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :layout_by_access

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  protected

  def layout_by_access
    if devise_controller?
      'devise'
    else
      'application'
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit devise_sign_up_param }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit devise_sign_in_param }
  end

  private

  def devise_sign_up_param
    [:username, :email, :password, :password_confirmation, :remember_me]
  end

  def devise_sign_in_param
    [:login, :username, :email, :password, :remember_me]
  end
end
