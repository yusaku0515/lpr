class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def after_sign_up_path_for(resource)
    users_signup2_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :family_name, :first_name, :age, :postal_code, :company_name, :address, :phone_number, :user_status])
  end
end
