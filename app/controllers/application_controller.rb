class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def logged_in?
    if !current_user
      redirect_to root_path
    end
  end

  def authenticate_owner
    unless @project.is_author?(current_user)
      redirect_to root_path
    end
  end

  def authenticate_member
    unless @project.members.include?(current_user)
      redirect_to root_path
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
