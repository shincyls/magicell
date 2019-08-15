class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(username: params[:session][:username])
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to dashboard_url, flash: { success: 'Logged In Successfully' }
    else
      redirect_to login_url, flash: { danger: 'User not found or Password Incorrect' }
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash: { success: 'Logged Out Successfully'}
  end

end
