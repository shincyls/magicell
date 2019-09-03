class TimesheetApprovalsController < ApplicationController
    include ApplicationHelper
    before_action :require_login

    def new
        @timesheet_approval = TimesheetApproval.new
    end

    def show
        respond_to :html, :js
        @timesheet_approval = TimesheetApproval.find(params[:id])
        @session = @timesheet_approval.session.to_date
        @timesheets = @timesheet_approval.employee.timesheets.order("date desc").year_month(@session.year,@session.month)
    end

    def create
        respond_to :html, :js
        @timesheet_approval = TimesheetApproval.new(timesheet_approval_params)
        if TimesheetApproval.exists?(employee_id: @timesheet_approval.employee_id, session: @timesheet_approval.session)
            flash.now[:warning] =  "Your Timesheet have been submitted before."
        elsif @timesheet_approval.save
            flash.now[:success] = "Your Timesheet have been sent to manager for review and approval."
        end
        @timesheets = current_user.employee.timesheets.order("date desc") if current_user.employee
        @timesheets = @timesheets.year_month(@timesheet_approval.session.to_date.year,@timesheet_approval.session.to_date.month)
        @session = @timesheet_approval.session
    end

    def ts_approval1
        respond_to :html, :js
        @ts = TimesheetApproval.find(params[:id])
        @ts.apv_1 = !@ts.apv_1
        @ts.save
    end

    def ts_approval2
        respond_to :html, :js
        @ts = TimesheetApproval.find(params[:id])
        @ts.apv_2 = !@ts.apv_2
        @ts.save
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
        params.require(:timesheet_approval).permit(:employee_id, :session, :year, :month, :apv_mgr_1_id, :apv_mgr_2_id)
    end

end