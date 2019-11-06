class SessionsController < ApplicationController

  def new
  end

  def create
    if User.exists?(username: params[:session][:username])
      user = User.find_by(username: params[:session][:username])
    elsif Employee.exists?(company_email: params[:session][:username])
      user = Employee.find_by(company_email: params[:session][:username]).user
    end

    if user 
      if user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to dashboard_url, flash: { success: 'Logged In Successfully.' }
      else
        redirect_to login_url, flash: { danger: 'Password is Wrong.' }
      end
    else
      redirect_to login_url, flash: { danger: 'User is not Found.' }
    end

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, flash: { success: 'Logged Out Successfully'}
  end

end
