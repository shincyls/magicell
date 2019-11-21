class MagicnetsController < ApplicationController
    include ApplicationHelper
    # before_action :logged_in?, except: :login
    
    def dashboard
      respond_to :html, :js
      unless logged_in?
        redirect_to login_path
      else
        if params[:page].to_i == 1
          redirect_to
        elsif params[:page].to_i == 2
          redirect_to
        elsif params[:page].to_i == 3
          redirect_to
        elsif params[:page].to_i == 4
          redirect_to
        elsif params[:page].to_i == 5
          redirect_to
        end
      end
    end

    def login
      respond_to :html, :js
      redirect_to dashboard_url if logged_in?
    end

    # Dashboards for each role

    # Employee Pages
    def dashemployee
      respond_to :js
      @employee = current_user.employee
      render template: "magicnets/view_emp/dashemployee"
    end

    # Load The Page
    def timesheetemployee
      respond_to :js
      render template: "magicnets/view_emp/timesheetemployee"
    end

    def expenseemployee
      respond_to :js
      render template: "magicnets/view_emp/expenseemployee"
    end

    # Finance Pages
    def dashfinance
      respond_to :js
      render template: "magicnets/view_fin/dashfinance"
    end

    def finance_timesheet
      respond_to :html, :js
      @timesheets = Timesheet.where(submitted: true)
      render template: "magicnets/view_fin/finance_timesheet"
    end

    # HR Pages
    def dashhr
      respond_to :js
      render template: "magicnets/view_hr/dashhr"
    end

    # PM Pages
    def dashpm
      respond_to :js
      render template: "magicnets/view_pm/dashpm"
    end

    def leave_approval
      respond_to :js
      @leaveaps = (Leaveap.where(apv_mgr_1_id: current_user.employee.id, status_leave_id: [2,3,4]) + Leaveap.where(apv_mgr_2_id: current_user.employee.id, status_leave_id: [2,3,4])).uniq
      render template: "magicnets/view_pm/leave_approval"
    end

    def timesheet_approval
      respond_to :html, :js
      @timesheets = TimesheetApproval.where(manager_id: current_user.employee.id).joins("LEFT JOIN timesheets on timesheet_approvals.timesheet_id = timesheets.id").where("timesheets.submitted = ?", true)
      render template: "magicnets/view_pm/timesheet_approval"
    end

    def expense_approval
      respond_to :html, :js
      @expenses = ExpenseApproval.where(manager_id: current_user.employee.id).joins("LEFT JOIN expenses on expense_approvals.expense_id = expenses.id").where("expenses.submitted = ?", true)
      render template: "magicnets/view_pm/expense_approval" 
    end

    # IT Pages
    def dashit
      respond_to :js
      render template: "magicnets/view_it/dashit"
    end

    def webrole
      respond_to :js
      render template: "magicnets/view_it/webrole"
    end

    def account
      respond_to :js
      render template: "magicnets/view_it/account"
    end

end