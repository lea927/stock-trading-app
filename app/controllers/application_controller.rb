class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # allow role_id to be accepted as part of signup parameters
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[role_id first_name last_name email password])
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password) }
  end
end
