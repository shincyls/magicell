class TimesheetApprovalsController < ApplicationController
    include ApplicationHelper
    before_action :require_login

    def new
        @timesheet_approval = TimesheetApproval.new
    end

    def create
        respond_to :html, :js
        @timesheet_approval = TimesheetApproval.new(timesheet_approval_params)
        if TimesheetApproval.exists?(employee_id: @timesheet_approval.employee_id, month: @timesheet_approval.month)
            flash.now[:warning] =  "Your Timesheet have been submitted before."
        elsif @timesheet_approval.save
            flash.now[:success] = "Your Timesheet have been sent to manager for approval."
        end

        @timesheets = current_user.employee.timesheets.order("date desc") if current_user.employee
        @timesheets = @timesheets.year_month(Date.today.year,@timesheet_approval.month)
        @month = @timesheet_approval.month
        
    end
    
    private
  
    def require_login
        unless logged_in?
          flash[:alert] = "You must be logged in to access this section"
          redirect_to root_url
        end
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def timesheet_approval_params
        params.require(:timesheet_approval).permit(:employee_id, :month, :apv_mgr_1_id, :apv_mgr_2_id)
    end

end