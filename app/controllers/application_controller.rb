class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :reset_session_timer, if: :user_signed_in?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :user_type, :cpf, :cnpj])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :user_type, :cpf, :cnpj])
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def reset_session_timer
    current_user.update_column(:last_activity_at, Time.current)
  end

end

