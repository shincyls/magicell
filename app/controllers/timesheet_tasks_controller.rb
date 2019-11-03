class TimesheetTasksController < ApplicationController
    include ApplicationHelper
    before_action :require_login

    def new
    end

    def create
      respond_to :html, :js
      date_now = Date.parse(params["timesheet_task"][:multi_date_from])
      date_end = Date.parse(params["timesheet_task"][:multi_date_to])
      params["timesheet_task"].delete("multi_date_from")
      params["timesheet_task"].delete("multi_date_to")
      while date_end >= date_now
        unless date_now.saturday? or date_now.sunday?
          @timesheet_task = TimesheetTask.new(timesheet_task_params)
          unless TimesheetTask.exists?(employee_id: @timesheet_task.employee_id, date: date_now)
            @timesheet_task.date = date_now
            @timesheet_task.save
          else # Update/Overwrite
            @timesheet_task = TimesheetTask.find_by(employee_id: @timesheet_task.employee_id, date: date_now)
            @timesheet_task.update(timesheet_task_params)
          end
        end
        date_now += 1.day
      end
      flash.now[:success] = "Your Timesheet have been created/updated."
      @timesheet = @timesheet_task.timesheet
    end

    def update
    end

    def destroy
        respond_to :html, :js
        @timesheet_task = TimesheetTask.find(params[:id])
        if @timesheet_task.destroy
            flash.now[:success] = "Task have been succesfully removed."
        else
            flash.now[:warning] = "This action couldn't performed due to error, please check with admin."
        end
        @timesheet = @timesheet_task.timesheet
    end
    
    private
  
    def require_login
        unless logged_in?
          flash[:alert] = "You must be logged in to access this section"
          redirect_to root_url
        end
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def timesheet_task_params
        params.require(:timesheet_task).permit(:employee_id, :project_id, :activity, :site_name, :location, :date, :time_in, :time_out, :time_break, :timesheet_id, :vehicle_number, :vehicle_owner_id)
    end

end