module RedirectToCurrentPageAfterSignIn
  extend ActiveSupport::Concern

  protected

  def authenticate_user!(opts = {})
    unless opts || user_signed_in? || devise_controller? || !redirectable?
      store_location_for(:user, request.fullpath)
    end
    super(opts)
  end

  private

  def redirectable?
    request.get? && !request.xhr? && is_navigational_format?
  end
end
