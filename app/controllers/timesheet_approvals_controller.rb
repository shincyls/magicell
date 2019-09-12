class TimesheetApprovalsController < ApplicationController
    include ApplicationHelper
    before_action :require_login

    def new
    end

    def create
      respond_to :html, :js
      @timesheet_approval = TimesheetApproval.new(timesheet_approval_params)
      @count = @timesheet_approval.timesheet.timesheet_approvals.count
      
      unless TimesheetApproval.exists?(timesheet_id: @timesheet_approval.timesheet_id, employee_id: @timesheet_approval.employee_id, manager_id: @timesheet_approval.manager_id)
        if (@count.to_i < 3)
            if @timesheet_approval.save
            flash.now[:success] = "Your Timesheet Approval have been created."
            end
        else
            flash.now[:warning] = "You cannot have more than 3 manager approvals for each timesheet."
        end 
      else
        flash.now[:warning] = "Manager Approval is already exists."
      end
      @timesheet = @timesheet_approval.timesheet
      @timesheets = current_user.employee.timesheets
    end

    def update
    end

    def destroy
        respond_to :html, :js
        @timesheet_approval = TimesheetApproval.find(params[:id])
        if @timesheet_approval.destroy
            flash.now[:success] = "Timesheet Approval  have been succesfully removed."
        else
            flash.now[:warning] = "This action couldn't performed due to error, please check with admin."
        end
        @timesheet = @timesheet_approval.timesheet
        @timesheets = current_user.employee.timesheets
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
        params.require(:timesheet_approval).permit(:timesheet_id, :employee_id, :manager_id)
    end

end