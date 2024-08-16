class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :reset_session_timer, if: :user_signed_in?
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: [
      :name, 
      :email, 
      :telefone, 
      :cpf, 
      :graduacao, 
      :periodo_curso, 
      :habilidades_tecnicas, 
      :numero_matricula,
      :nome_empresa,
      :curriculo])
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
    session[:expires_at] = 30.minutes.from_now
  end

  def check_session_timeout
    if session[:expires_at] && Time.current > session[:expires_at]
      reset_session
      redirect_to new_user_session_path, alert: 'Sua sessão expirou.'
    end
  end

  def set_session_time_left
    if user_signed_in?
      session_expiry_time = current_user.last_activity_at + 30.minutes
      @time_left = session_expiry_time - Time.current
    end
  end

end

