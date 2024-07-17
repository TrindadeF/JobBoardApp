class SessionTimeout
  def initialize(app)
    @app = app
  end

  def call(env)
    request = ActionDispatch::Request.new(env)
    if request.session[:user_id]
      user = User.find(request.session[:user_id])
      if user.last_activity_at && user.last_activity_at < 30.minutes.ago
        request.session.destroy
        request.flash[:alert] = 'Sua sessão expirou devido à inatividade.'
      end
    end
    @app.call(env)
  end
end
