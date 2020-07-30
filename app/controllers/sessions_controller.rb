class SessionsController < ApplicationController
  skip_before_action :ensure_login, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(username: params[:user][:username])
    if user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'Logged in successfully'
    else
      redirect_to login_path, alert: 'invalid data'
    end
  end

  def destroy
    reset_session
    redirect_to login_path, notice: 'successful logout'
  end
end
