class ProfilesController < ApplicationController
  def show
    @user = current_user
    @profile_changes = @user.versions.order(created_at: :desc)  # Obtém todas as versões do usuário ordenadas pela data
  end
end
