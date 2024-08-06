class Users::SessionsController < Devise::SessionsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  def after_sign_in_path_for(resource)
    if resource.user_type == 'academic'
      flash[:notice] = "Login realizado como acadêmico !"
      academic_root_path
    elsif resource.user_type == 'recruiter'
      flash[:notice] = "Login realizado como recrutador !"
      recruiter_root_path
    else
      root_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  def destroy
    signed_out = (Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name))
    set_flash_message! :notice, :signed_out if signed_out
    yield if block_given?
    respond_to_on_destroy
  end

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
      :curriculo,
      :nome_empresa,
      :razao_social
    ])
  end

end
