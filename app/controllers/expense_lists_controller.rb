class ExpenseListsController < ApplicationController
  before_action :logged_in?
  after_action :return_employee, only: [:create]
  before_action :return_default, only: [:index, :project, :finance]
  skip_before_action :verify_authenticity_token, only: [:submitall, :approvepmall, :approvefmall]

  def index
    respond_to :html, :js
    @expense_lists = ExpenseList.where(employee_id: current_user.employee.id).order("date desc")
    @backup_lists = @expense_lists
    if params[:value].present?
      @expense_lists = ExpenseList.where(employee_id: current_user.employee.id, status_expense_id: params[:value].to_i).order("date desc")
    end
    @expense_list= ExpenseList.new
    if @status == 0
      @expense_lists = @expense_lists.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ?", @year, @month)
    else
      @expense_lists = @expense_lists.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_expense_id = ?", @year, @month, @status)
    end
  end

  def summary
    respond_to :html, :js
    @expense_lists = ExpenseList.all.order("created_at desc")
  end

  def project
    respond_to :html, :js
    @projects = Project.where(manager_id: current_user.employee.id).pluck(:id)
    @expense_lists = ExpenseList.where(project_id: @projects, status_expense_id: [2,3,4,5,6]).order("date desc")
    if @status == 0
      @expense_lists = @expense_lists.where("
        DATE_PART('year', date) >= ? and 
        DATE_PART('year', date) <= ? and 
        DATE_PART('month', date) >= ? and 
        DATE_PART('month', date) <= ? and 
        status_expense_id = ?
        ", @yearb, @year, @monthb, @month, [2,3,4,5,6])
    else
      @expense_lists = @expense_lists.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_expense_id = ?", @year, @month, @status)
    end
  end

  def finance
    respond_to :html, :js
    @expense_lists = ExpenseList.where(status_expense_id: [4,5,6]).order("date desc")
    if @status == 0
      @expense_lists = @expense_lists.where("
        DATE_PART('year', date) >= ? and 
        DATE_PART('year', date) <= ? and 
        DATE_PART('month', date) >= ? and 
        DATE_PART('month', date) <= ? and 
        status_expense_id = ?
        ", @yearb, @year, @monthb, @month, [4,5,6])
    else
      @expense_lists = @expense_lists.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_expense_id = ?", @year, @month, @status)
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
    render 'datarow'
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
    render 'datarow'
  end

  # DELETE /expense_lists/1
  def destroy
    respond_to :html, :js
    @expense_list = ExpenseList.find(params[:id])
    if @expense_list.destroy
      flash.now[:success] = "Expense have been successfully removed."
      @expense_lists = ExpenseList.where(employee_id: current_user.employee.id).order("date desc")
    else
      flash.now[:warning] = "This action couldn't be performed due to error, please check with admin."
    end
    render 'datarow'
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
    render 'datarow'
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
    render 'datarow'
  end

  def approvepmall
    respond_to :js
    @receive = JSON.parse params[:ids]
    count = ExpenseList.where(id: @receive, status_expense_id: 2).update_all("status_expense_id = 4")
    flash.now[:success] = "#{count} Pending Item(s) have been successfully approved."
    @expense_lists = ExpenseList.where(id: @receive)
    render 'datarow'
  end

  def approvefmall
    respond_to :js
    @receive = JSON.parse params[:ids]
    count = ExpenseList.where(id: @receive, status_expense_id: 4).update_all("status_expense_id = 6")
    flash.now[:success] = "#{count} Pending Item(s) have been successfully approved."
    @expense_lists = ExpenseList.where(id: @receive)
    render 'datarow'
  end

  def approvepm
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
    if @expense_list.status_expense_id == 2 # Approve by PM
      @expense_list.update(status_expense_id: 4)
      flash.now[:success] = "Expense have successfully approved."
    end
    render 'datarow'
  end

  def rejectpm
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
    if @expense_list.status_expense_id == 2 # Reject by PM
      @expense_list.update(status_expense_id: 3)
      flash.now[:success] = "Expense have successfully rejected."
    end
    render 'datarow'
  end

  def approvefm
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
    if @expense_list.status_expense_id == 4 # Approve by FM
      @expense_list.update(status_expense_id: 6)
      flash.now[:success] = "Expense have successfully approved."
    end
    render 'datarow'
  end

  def rejectfm
    respond_to :html, :js
    @expense_list= ExpenseList.find(params[:id])
    if @expense_list.status_expense_id == 4 # Reject by FM
      @expense_list.update(status_expense_id: 5)
      flash.now[:success] = "Expense have successfully rejected."
    end
    render 'datarow'
  end

  private

  def datarow
    respond_to :js
  end 

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

  def return_default
    params[:year] = Date.today.year if params[:year].nil?
    params[:month] = Date.today.month if params[:month].nil?
    params[:yearb] = (Date.today - 2.month).year if params[:year].nil?
    params[:monthb] = (Date.today - 2.month).month if params[:month].nil?
    params[:status] = 0 if params[:status].nil?
    @year = params[:year].to_i
    @month = params[:month].to_i
    @yearb = params[:yearb].to_i
    @monthb = params[:monthb].to_i
    @status = params[:status].to_i
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def expense_list_params
    params.require(:expense_list).permit(:date, :employee_id, :project_id, :expense_id, :fuel_claim, :toll_claim, :parking_claim, :allowance_claim, :medical_claim ,:others_claim, :odometer_reading, :holiday, :attachment_link, :remarks)
  end
    
    
end