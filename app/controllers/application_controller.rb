class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  def authenticate_admin!
    unless user_signed_in? && current_user.admin
      redirect_to root_path, notice: "You're not an admin, pal"
    end
  end

  def authenticate_user!
    unless user_signed_in?
      redirect_to root_path, notice: "You gotta sign in, ol' sport"
    end
  end

  def check_same_user!
    unless current_user == User.find(params[:user_id])
      redirect_to root_path, notice: "You're not that guy, get outta here"
    end
  end
end
