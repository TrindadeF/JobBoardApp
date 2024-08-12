class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_permitted_parameters, if: :devise_controller?
  require 'net/http'
  require 'json'


  def create
    @user = User.new(sign_up_params)
    Rails.logger.info("User type: #{@user.user_type}")
  
    case @user.user_type
    when 'academic'
      save_user
    when 'recruiter'
      if cnpj_valid?(@user.cnpj)
        save_user
      else
        @user.errors.add(:cnpj, 'is invalid or does not exist')
        Rails.logger.info("CNPJ is invalid or does not exist")
        render :new
      end
    else
      @user.errors.add(:user_type, 'is not a valid user type')
      Rails.logger.info("User type is not valid")
      render :new
    end
  end 

  def save_user
    if @user.save
      if @user.recruiter?
        redirect_to recruiter_root_path, notice: 'User was successfully created.'
      else
        redirect_to academic_root_path, notice: 'User was successfully created.'
      end
    else
      render :new
    end
  end

  def update
    self.resource = resource_class.to_adapter.get!(send(:"current_#{resource_name}").to_key)
    prev_unconfirmed_email = resource.unconfirmed_email if resource.respond_to?(:unconfirmed_email)

    resource_updated = update_resource(resource, account_update_params)
    yield resource if block_given?
    if resource_updated
      if is_flashing_format?
        flash_key = update_needs_confirmation?(resource, prev_unconfirmed_email) ?
          :update_needs_confirmation : :updated
        set_flash_message :notice, flash_key
      end
      bypass_sign_in resource, scope: resource_name
      respond_with resource, location: after_update_path_for(resource)
    else
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end

  def destroy
    resource.destroy
    Devise.sign_out_all_scopes ? sign_out : sign_out(resource_name)
    set_flash_message! :notice, :destroyed
    yield resource if block_given?
    respond_with_navigational(resource){ redirect_to after_sign_out_path_for(resource_name) }
  end


  def after_sign_up_path_for(resource)
    super(resource)
  end

  def after_update_path_for(resource)
    super(resource)
  end

  def after_inactive_sign_up_path_for(resource)
    super(resource)
  end


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:name, :email, :password, :password_confirmation, :user_type,
                         :telefone, :cpf, :graduacao, :periodo_curso, :habilidades_tecnicas, :numero_matricula, :curriculo,
                         :nome_empresa, :cnpj, :razao_social)
    end

    devise_parameter_sanitizer.permit(:account_update) do |user_params|
      user_params.permit(:name, :email, :password, :password_confirmation, :current_password, :user_type,
                         :telefone, :cpf, :graduacao, :periodo_curso, :habilidades_tecnicas, :numero_matricula, :curriculo,
                         :nome_empresa, :cnpj, :razao_social)
    end

  end

  def cnpj_valid?(cnpj)
    uri = URI("https://www.receitaws.com.br/v1/cnpj/#{cnpj}")
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    data['status'] == 'OK'
    rescue
      false
    end
  end
  
