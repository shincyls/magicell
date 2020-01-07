class ExpenseListsController < ApplicationController
  before_action :logged_in?
  after_action :return_employee, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:submitall, :approvepmall, :approvefmall]

  def index
    respond_to :html, :js
    @expense_lists = ExpenseList.where(employee_id: current_user.employee.id).order("date desc")
    @backup_lists = @expense_lists
    if params[:value].present?
      @expense_lists = ExpenseList.where(employee_id: current_user.employee.id, status_expense_id: params[:value].to_i).order("date desc")
    end
    @expense_list= ExpenseList.new
  end

  def summary
    respond_to :html, :js
    @expense_lists = ExpenseList.all.order("created_at desc")
  end

  def project
    respond_to :html, :js
    @projects = Project.where(manager_id: current_user.employee.id).pluck(:id)
    @expense_lists = ExpenseList.where(project_id: @projects, status_expense_id: [2,3,4,5,6]).order("date desc")
    @backup_lists = @expense_lists
    if params[:value].to_i > 1
      @expense_lists = ExpenseList.where(project_id: @projects, status_expense_id: params[:value]).order("date desc")
    end
  end

  def finance
    respond_to :html, :js
    @expense_lists = ExpenseList.where(status_expense_id: [4,5,6]).order("date desc")
    @backup_lists = @expense_lists
    if params[:value].to_i > 1
      @expense_lists = ExpenseList.where(status_expense_id: params[:value]).order("date desc")
    end
  end

  def new
    respond_to :html, :js
    @expense_list= ExpenseList.new
  end

  def show
    respond_to :html, :js
  end

  # GET /expense_lists/1/edit
  def edit
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
  end

  # POST /expense_lists
  def create
    respond_to :html, :js
    @expense_list = ExpenseList.new(expense_list_params)
    if @expense_list.save
      flash.now[:success] = "New Expense have been successfully created."
    else
      flash.now[:warning] = @expense_list.errors.full_messages
    end
    @expense_list = ExpenseList.new(expense_list_params)
    @expense_lists = ExpenseList.where(employee_id: current_user.employee.id).order("date desc")
    @backup_lists = @expense_lists
  end

  # PATCH/PUT /expense_lists/1
  def update
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
    if @expense_list.update(expense_list_params)
      flash.now[:success] = "Expense information have been successfully updated."
    else
      flash.now[:warning] = @expense_list.errors.full_messages
    end
  end

  # DELETE /expense_lists/1
  def destroy
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
    if @expense_list.destroy
      flash.now[:success] = "Expense have been successfully removed."
      @expense_lists = ExpenseList.where(employee_id: current_user.employee.id).order("date desc")
    else
      flash.now[:warning] = "This action couldn't be performed due to error, please check with admin."
    end
  end

  def submit
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
    if @expense_list.status_expense_id == 1
      @expense_list.update(status_expense_id: 2, submitted_at: Time.now)
      flash.now[:success] = "Expense have successfully submitted."
    elsif @expense_list.status_expense_id == 3
      @expense_list.update(status_expense_id: 2)
      flash.now[:success] = "Expense have successfully resubmitted."
    elsif @expense_list.status_expense_id == 5
      @expense_list.update(status_expense_id: 4)
      flash.now[:success] = "Expense have successfully resubmitted."
    end
  end

  def submitall
    respond_to :js
    @receive = JSON.parse params[:ids]
    @expense_lists = ExpenseList.where(id: @receive, status_expense_id: [1,3,5])
    count = @expense_lists.count
    @expense_lists.each do |exp|
      if exp.status_expense_id == 1
        exp.update(status_expense_id: 2, submitted_at: Time.now)
      elsif exp.status_expense_id == 3
        exp.update(status_expense_id: 2)
      elsif exp.status_expense_id == 5
        exp.update(status_expense_id: 4)
      end
    end
    flash.now[:success] = "#{count} Pending Item(s) have been successfully submitted."
  end

  def approvepmall
    respond_to :js
    @receive = JSON.parse params[:ids]
    @expense_lists = ExpenseList.where(id: @receive, status_expense_id: 2)
    count = @expense_lists.count
    @expense_lists.each do |exp|
      exp.update(status_expense_id: 4)
    end
    flash.now[:success] = "#{count} Pending Item(s) have been successfully approved."
  end

  def approvefmall
    respond_to :js
    @receive = JSON.parse params[:ids]
    @expense_lists = ExpenseList.where(id: @receive, status_expense_id: 4)
    count = @expense_lists.count
    @expense_lists.each do |exp|
      exp.update(status_expense_id: 6)
    end
    flash.now[:success] = "#{count} Pending Item(s) have been successfully approved."
  end

  def approvepm
    respond_to :html, :js
    @expense_list= ExpenseList.where(params[:id])
    if @expense_list.status_expense_id == 2 # Approve by PM
      @expense_list.update(status_expense_id: 4)
      flash.now[:success] = "Expense have successfully approved."
    end
  end

  def rejectpm
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
    if @expense_list.status_expense_id == 2 # Reject by PM
      @expense_list.update(status_expense_id: 3)
      flash.now[:success] = "Expense have successfully rejected."
    end
  end

  def approvefm
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
    if @expense_list.status_expense_id == 4 # Approve by PM
      @expense_list.update(status_expense_id: 6)
      flash.now[:success] = "Expense have successfully approved."
    end
  end

  def rejectfm
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
    if @expense_list.status_expense_id == 4 # Reject by PM
      @expense_list.update(status_expense_id: 5)
      flash.now[:success] = "Expense have successfully rejected."
    end
  end

  private

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this section"
      redirect_to root_url
    end
  end

  def return_employee
    @expense_lists = ExpenseList.where(employee_id: current_user.employee.id).order("date desc")
    @backup_lists = @expense_lists
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def expense_list_params
    params.require(:expense_list).permit(:date, :employee_id, :project_id, :expense_id, :fuel_claim, :toll_claim, :parking_claim, :allowance_claim, :medical_claim ,:others_claim, :odometer_reading, :holiday, :attachment_link)
  end
    
    
end