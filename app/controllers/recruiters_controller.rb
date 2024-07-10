class RecruitersController < Users::SessionsController
    before_action :authenticate_user!
    def dashboard

    end
  end