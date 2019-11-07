class ExpenseListsController < ApplicationController
    include ApplicationHelper
    before_action :require_login

    def new
    end

    def create
      respond_to :html, :js
      message = ""
      date_now = Date.parse(params["expense_list"][:multi_date_from])
      date_end = Date.parse(params["expense_list"][:multi_date_to])
      params["expense_list"].delete("multi_date_from")
      params["expense_list"].delete("multi_date_to")
      
      while date_end >= date_now
        unless date_now.saturday? or date_now.sunday?
          @expense_list = ExpenseList.new(expense_list_params)
          if (@expense_list.expense.year == date_now.year) & (@expense_list.expense.month == date_now.month)
            unless ExpenseList.exists?(employee_id: @expense_list.employee_id, project_id: @expense_list.project_id, date: date_now)
              @expense_list.date = date_now
              @expense_list.save
            else # Update/Overwrite
              @expense_list = ExpenseList.find_by(employee_id: @expense_list.employee_id, project_id: @expense_list.project_id, date: date_now)
              @expense_list.update(expense_list_params)
            end
          else
            message = ", but lists not from #{@expense_list.expense.session} are ignored"
          end
        end
        date_now += 1.day
      end
      flash.now[:success] = "Your Expense have been created/updated#{message}."
      @expense = @expense_list.expense
    end

    def edit
      respond_to :html, :js
      @list = ExpenseList.find(params[:id])
    end

    def update
      respond_to :html, :js
      @expense_list = ExpenseList.find(params[:id])
      if @expense_list.update(expense_list_params)
        flash.now[:success] = "Your Form have been updated."
        @expense_lists = current_user.employee.expense_lists.order("created_at desc") if current_user.employee
      else
        flash.now[:warning] = "Opps! Something Wrong Please Check with Admin"
      end
      expense = @expense_list.expense
    end

    def destroy
        respond_to :html, :js
        @expense_list = ExpenseList.find(params[:id])
        if @expense_list.destroy
            flash.now[:success] = "List have been succesfully removed."
        else
            flash.now[:warning] = "This action couldn't performed due to error, please check with admin."
        end
        @expense = @expense_list.expense
    end
    
    private
  
    def require_login
        unless logged_in?
          flash[:alert] = "You must be logged in to access this section"
          redirect_to root_url
        end
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def expense_list_params
        params.require(:expense_list).permit(:employee_id, :project_id, :expense_id, :fuel_claim, :toll_claim, :parking_claim, :allowance_claim, :others_claim, :medical_claim, :remarks)
    end

end