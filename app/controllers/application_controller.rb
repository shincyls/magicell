class ApplicationController < ActionController::Base
  
  def current_number
    current_number = 1
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def require_hr_write
    if current_user.webrole.wr_hr
      return true
    else
      flash.now[:alert] = "You have no write access for this action."
    end
  end

  def require_it_write
    if current_user.webrole.wr_it
      return true
    else
      flash.now[:alert] = "You have no write access for this action."
    end
  end

  def require_employee_write
    if current_user.webrole.wr_emp
      return true
    else
      flash.now[:alert] = "You have no write access for this action."
    end
  end

  def require_promgr_write
    if current_user.webrole.wr_pro_mgr
      return true
    else
      flash.now[:alert] = "You have no write access for this action."
    end
  end

  def require_dptmgr_write
    if current_user.webrole.wr_dpt_mgr
      return true
    else
      flash.now[:alert] = "You have no write access for this action."
    end
  end
  
  private
  # Returns true if current_user exists, false otherwise
  def logged_in?
    !current_user.nil?
  end

  # a convenient method to set the session to given user's id with the `:user_id` key
  def sign_in(user)
    session[:user_id] = user.id
  end

  # clears the session by setting the value of `:user_id` key to `nil`
  def sign_out
    session[:user_id] = nil
  end

  helper_method :logged_in?, :current_user

end
