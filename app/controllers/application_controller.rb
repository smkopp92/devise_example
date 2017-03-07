class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def authenticate_admin!
    unless user_signed_in? && current_user.admin
      redirect_to root_path, notice: "You're not an admin, pal"
    end
  end
end
