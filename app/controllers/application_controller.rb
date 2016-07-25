class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    added_attrs=[:email, :password, :password_confirmation, :remember_me, :name, :surname, :city]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(root_path)
  end
end
