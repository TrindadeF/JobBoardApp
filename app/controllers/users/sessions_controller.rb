class Users::SessionsController < Devise::SessionsController
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:user_type])
    devise_parameter_sanitizer.permit(:account_update, keys: [:user_type])
  end

  def create
    super do |resource|
      if resource.user_type == 'academic'
        flash[:notice] = "Login efetuado como Acadêmico"
        redirect_to academic_root_path and return
      elsif resource.user_type == 'recruiter'
        flash[:notice] = "Login efetuado como Recrutador"
        redirect_to recruiter_root_path and return
      else
        flash[:alert] = "Tipo de usuário desconhecido."
        redirect_to root_path and return
      end
    end
  end

end
