class PasswordResetsController < ApplicationController
  
  def new
  end

  def create
    if Employee.find_by(company_email: params[:email])
      @employee = Employee.find_by(company_email: params[:email])
      @user = User.find_by(employee_id: @employee.id)
      @user.send_password_reset
      @user.save(validate: false)
      redirect_to dashboard_url
      flash[:notice] = 'Please Check Your Email for Password Reset Instruction'
    else
      respond_to do |format|
        format.html
        format.js { flash.now[:alert] = "User Email is not found" }
      end
    end
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 1.hour.ago
      flash[:alert] = 'Your Password Reset link has expired'
      redirect_to new_password_reset_path
    elsif @user.update(password_params)
      flash[:notice] = 'Your Password has been reset successfully!'
      redirect_to root_url
    else
      render :edit
    end
  end
  
  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def password_params
    params.require(:user).permit(:password)
  end

end
