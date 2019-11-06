class ExpenseApprovalsController < ApplicationController
    include ApplicationHelper
    before_action :require_login

    def new
    end

    def create
      respond_to :html, :js
      @expense_approval = ExpenseApproval.new(expense_approval_params)
      @count = @expense_approval.expense.expense_approvals.count
      
      unless ExpenseApproval.exists?(expense_id: @expense_approval.expense_id, employee_id: @expense_approval.employee_id, manager_id: @expense_approval.manager_id)
        if (@count.to_i < 3)
            if @expense_approval.save
            flash.now[:success] = "Your Expense Approval have been created."
            end
        else
            flash.now[:warning] = "You cannot have more than 3 manager approvals for each expense."
        end 
      else
        flash.now[:warning] = "Manager Approval is already exists."
      end
      @expense = @expense_approval.expense
      @expenses = current_user.employee.expenses
    end

    def update
    end

    def show
        respond_to :html, :js
        @expense_approval = ExpenseApproval.find(params[:id])
        @expense = @expense_approval.expense
    end

    def destroy
        respond_to :html, :js
        @expense_approval = ExpenseApproval.find(params[:id])
        if @expense_approval.destroy
            flash.now[:success] = "Expense Approval have been succesfully removed."
        else
            flash.now[:warning] = "This action couldn't performed due to error, please check with admin."
        end
        @expense = @expense_approval.expense
        @expenses = current_user.employee.expenses
    end

    def approve
        respond_to :html, :js
        @la = ExpenseApproval.find(params[:id])
        @la.approval = !@la.approval
        @la.save
        if @la.approval
            flash.now[:success] = "Expense Claim Approval is Approved." 
            UserMailer.approve_expense(@la.id).deliver
        end
    end

    def reject
        respond_to :html, :js
        @la = ExpenseApproval.find(params[:id])
        @la.reject = !@la.reject
        @la.save
        if @la.reject
            flash.now[:alert] = "Expense Claim Approval is Rejected." 
            # Allow Applicant to Edit and Resubmit
            @expense = @la.expense
            @expense.update(submitted: false)
            @expense.save
        end
    end

    private
  
    def require_login
        unless logged_in?
          flash[:alert] = "You must be logged in to access this section"
          redirect_to root_url
        end
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_approval_params
        params.require(:expense_approval).permit(:expense_id, :employee_id, :manager_id)
    end

end