class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :get_unread_count
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name,
      :last_name])
  end

  def get_unread_count
    @unread_count = Notification.where("user_id = ? AND status = 'unread'", current_user.id).count
  end
end
