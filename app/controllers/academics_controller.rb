class AcademicsController < ApplicationController
  before_action :authenticate_user!

    def dashboard
      @user = current_user
      @my_applications = current_user.applications
    end

  end