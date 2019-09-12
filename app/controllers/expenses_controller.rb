class ExpensesController < ApplicationController
    include ApplicationHelper
    before_action :require_login
  
    def index
      respond_to :html, :js
    end

    def new
      respond_to :html, :js
      @expense = Expense.new
    end
  
    # POST /expenses
    def create
      @expense = Expense.new(expense_params)
      unless Expense.exists?(employee_id: @expense.employee_id, year: @expense.year, month: @expense.month)
        if @expense.save
          flash.now[:success] = "Your Expense Claim is successfully created."
        else
          flash.now[:warning] = "Oops, something wrong."
        end
      else
        flash.now[:warning] = "Your Expense Claim for #{@expense.year}-#{@expense.month} is already exist."
      end
    end

    # GET /expenses/1/edit
    def edit
      respond_to :html, :js
      @expense = Expense.find(params[:id])
    end
    
    # GET /expenses/1
    def show
    end
  
    # PATCH/PUT /expenses/1
    def update
      respond_to :html, :js
      @expense = Expense.find(params[:id])
      unless Expense.exists?(employee_id: @expense.employee.id, project_id: @expense.project_id, year: @expense.year, month: @expense.month)
        if @expense.update(expense_params)
          flash.now[:success] = "Your Expense is successfully created."
        end
      else
        flash.now[:warning] = "Your Expense for #{@expense.year}-#{@expense.month} is already exist."
      end
    end
  
    # DELETE /expenses/1
    # DELETE /expenses/1.json
    def destroy
      respond_to :html, :js
      @expense = Expense.find(params[:id])
      if @expense.destroy
        flash.now[:success] = "Expense have been remove."
      else
        flash.now[:warning] = "This action couldn't performed due to error, please check with admin."
      end
    end

    # GET /expenses/1/taskadd
    def listadd
      respond_to :html, :js
      @expense = Expense.find(params[:id])
      @list = ExpenseList.new
    end

    # GET /expenses/1/taskadd
    def approvaladd
      respond_to :html, :js
      @expense = Expense.find(params[:id])
      @expense_approval = ExpenseApproval.new
    end

    # POST /expenses/1/submit
    def submit
      respond_to :html, :js
      @expense = Expense.find(params[:id])
      if @expense.submitted
        flash.now[:success] = "Your Expense Claim is already submitted."
      elsif (@expense.expense_approvals.count <= 0)
        flash.now[:warning] = "Your must enter at least 1 Manager Approval."
      else
        if @expense.update(submitted: true)
          flash.now[:success] = "Your Expense Claim have been succesfully submitted."
        end
      end
      @expense_approval = ExpenseApproval.new
      @expenses = current_user.employee.expenses
  end
  
    private
  
    def require_login
        unless logged_in?
          flash[:alert] = "You must be logged in to access this section"
          redirect_to root_url
        end
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_params
      params.require(:expense).permit(:employee_id, :year, :month)
    end

    def no_duplicate
      @expense = Expense.find(params[:id])
      if Expense.exists?(employee_id: @expense.employee_id, year: @expense.year, month: @expense.month)
        return false
      else
        return true
      end
    end
      
  end
  

