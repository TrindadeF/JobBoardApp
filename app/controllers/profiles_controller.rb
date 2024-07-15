class ProfilesController < ApplicationController
  def show
    @user = current_user
    @profile_changes = @user.versions.order(created_at: :desc) 
  end
end
