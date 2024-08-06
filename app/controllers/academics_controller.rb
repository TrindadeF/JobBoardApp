class AcademicsController < ApplicationController
  before_action :academic_params, if: :devise_controller?

    def dashboard
      @user = current_user
      @my_applications = current_user.applications
    end

    def edit
      
    end
  
    def update
      if @user.update(academic_params)
        redirect_to @user, notice: 'Profile updated successfully.'
      else
        render :edit
      end
    end
  
    private
  
    def set_user
      @user = Academics.find(params[:id])
    end

  end