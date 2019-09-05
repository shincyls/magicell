class UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except:[:index, :show, :new, :create, :make]

  # When registering for new user
  def new
    @user = User.new
  end

  # GET /users
  def index
    @users = current_users
  end

  # GET /users/:id
  def show
  end

  # GET /users/:id/edit
  def edit
  end

  # POST /users
  def create
    respond_to :html, :js
    @user = User.new(user_params)
    if @user.save
      flash.now[:success] = "Employee's login account have been successfully created."
    else
      flash.now[:warning] = @employee.errors.full_messages
    end
  end

  # POST
  def make
    respond_to :html, :js
    @employee = Employee.find(params[:id])
    unless @employee.company_email.empty?
      @dfpw = WebappContent.find_by(name: "Default Password").param
      @user = User.new(username: @employee.company_email.split('@').first, password: @dfpw, employee_id: params[:id])
      if @user.save
        flash.now[:success] = "#{@user.username} login have been successfully created."
      else
        flash.now[:warning] = "Oops! Something was wrong, please check with admin"
      end
    else
      flash.now[:warning] = "Employee's Company Email with @magicell.com.my must be presense."
    end
  end

  # PATCH/PUT /users/:id
  def update
    respond_to :html, :js
    if @user.update(user_params)
      redirect_to @user, flash: { success: 'User was successfully updated.' }
    else
      redirect_to root_url, flash: { danger: 'Failed to Edit user.' }
    end
  end

  # DELETE /users/:id
  def destroy
    session[:user_id] = nil
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, flash: { danger: 'User was successfully destroyed.' } }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # before_action, only owner can :edit :update :destroy their profile
    def authenticate_user!
      if current_user.id != @user.id
        redirect_back(fallback_location: root_path)
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :email, :birthday, :password, :avatar)
    end
    
end
