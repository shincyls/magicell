class TimesheetTasksController < ApplicationController
    before_action :logged_in?
    after_action :return_employee, only: [:create]
    skip_before_action :verify_authenticity_token, only: [:submitall, :approvepmall, :approvefmall]

    def index
      respond_to :html, :js
      @timesheet_tasks = TimesheetTask.where(employee_id: current_user.employee.id).order("date desc")
      @backup_lists = @timesheet_tasks
      if params[:value].present?
        @timesheet_tasks = TimesheetTask.where(employee_id: current_user.employee.id, status_timesheet_id: params[:value].to_i).order("date desc")
      end
      @timesheet_task = TimesheetTask.new
    end

    def project
      respond_to :html, :js
      @projects = Project.where(manager_id: current_user.employee.id).pluck(:id)
      @timesheet_tasks = TimesheetTask.where(project_id: @projects, status_timesheet_id: [2,3,4,5,6]).order("date desc")
      @backup_lists = @timesheet_tasks
      if params[:value].to_i >= 2
        @timesheet_tasks = TimesheetTask.where(project_id: @projects, status_timesheet_id: params[:value]).order("date desc")
      end
    end

    def finance
      respond_to :html, :js
      @timesheet_tasks = TimesheetTask.where(status_timesheet_id: [4,5,6]).order("date desc")
      @backup_lists = @timesheet_tasks
      if params[:value].to_i >= 4
        @timesheet_tasks = TimesheetTask.where(status_timesheet_id: params[:value]).order("date desc")
      end
    end

    def new
      respond_to :html, :js
      @timesheet_task = TimesheetTask.new
    end

    def show
      respond_to :html, :js
    end
  
    # GET /timesheet_tasks/1/edit
    def edit
      respond_to :html, :js
      @timesheet_task = TimesheetTask.find(params[:id])
    end
  
    # POST /timesheet_tasks
    def create
      respond_to :html, :js
      message = ""
      date_now = Date.parse(params["timesheet_task"][:multi_date_from])
      date_end = Date.parse(params["timesheet_task"][:multi_date_to])
      params["timesheet_task"].delete("multi_date_from")
      params["timesheet_task"].delete("multi_date_to")
      while date_end >= date_now
          @timesheet_task = TimesheetTask.new(timesheet_task_params)
          unless TimesheetTask.exists?(employee_id: @timesheet_task.employee_id, date: date_now)
            @timesheet_task.date = date_now
            if @timesheet_task.save
              flash.now[:success] = "Your Timesheet have been added#{message}."
            else
              flash.now[:warning] = @timesheet_task.errors.full_messages
            end
          else # Update/Overwrite
            message = ", but tasks with duplicated date are ignored"
          end
        # end
        date_now += 1.day
      end
      if message.empty?
        flash.now[:success] = "Your Timesheet have been added."
      else
        flash.now[:warning] = "Done, but some tasks with existed date are not added."
      end
      @timesheet_tasks = TimesheetTask.where(employee_id: current_user.employee.id).order("date desc")
      @backup_lists = @timesheet_tasks
    end
  
    # PATCH/PUT /timesheet_tasks/1
    def update
      respond_to :html, :js
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.update(timesheet_task_params)
        flash.now[:success] = "Timesheet information have been successfully updated."
      else
        flash.now[:warning] = @timesheet_task.errors.full_messages
      end
    end
  
    # DELETE /timesheet_tasks/1
    def destroy
      respond_to :html, :js
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.destroy
        flash.now[:success] = "Timesheet have been successfully removed."
      else
        flash.now[:warning] = "This action couldn't be performed due to error, please check with admin."
      end
    end

    def submit
      respond_to :html, :js
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.status_timesheet_id == 1
        @timesheet_task.update(status_timesheet_id: 2, submitted_at: Time.now)
        flash.now[:success] = "Timesheet have successfully submitted."
      elsif @timesheet_task.status_timesheet_id == 3
        @timesheet_task.update(status_timesheet_id: 2)
        flash.now[:success] = "Timesheet have successfully resubmitted."
      elsif @timesheet_task.status_timesheet_id == 5
        @timesheet_task.update(status_timesheet_id: 4)
        flash.now[:success] = "Timesheet have successfully resubmitted."
      end
    end

    def submitall
      respond_to :js
      @receive = JSON.parse params[:ids]
      @timesheet_tasks = TimesheetTask.where(id: @receive, status_timesheet_id: [1,3,5])
      count = @timesheet_tasks.count
      @timesheet_tasks.each do |task|
        if task.status_timesheet_id == 1
          task.update(status_timesheet_id: 2, submitted_at: Time.now)
        elsif task.status_timesheet_id == 3
          task.update(status_timesheet_id: 2)
        elsif task.status_timesheet_id == 5
          task.update(status_timesheet_id: 4)
        end
      end
      flash.now[:success] = "#{count} Pending Item(s) have been successfully submitted."
    end

    def approvepmall
      respond_to :js
      @receive = JSON.parse params[:ids]
      @timesheet_tasks = TimesheetTask.where(id: @receive, status_timesheet_id: 2)
      count = @timesheet_tasks.count
      @timesheet_tasks.each do |task|
        task.update(status_timesheet_id: 4)
      end
      flash.now[:success] = "#{count} Pending Item(s) have been successfully approved."
    end
  
    def approvefmall
      respond_to :js
      @receive = JSON.parse params[:ids]
      @timesheet_tasks = TimesheetTask.where(id: @receive, status_timesheet_id: 4)
      count = @timesheet_tasks.count
      @timesheet_tasks.each do |task|
        task.update(status_timesheet_id: 6)
      end
      flash.now[:success] = "#{count} Pending Item(s) have been successfully approved."
    end

    def approvepm
      respond_to :html, :js
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.status_timesheet_id == 2 # Approve by PM
        @timesheet_task.update(status_timesheet_id: 4)
        flash.now[:success] = "Timesheet have successfully approved."
      end
    end

    def rejectpm
      respond_to :html, :js
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.status_timesheet_id == 2 # Reject by PM
        @timesheet_task.update(status_timesheet_id: 3)
        flash.now[:success] = "Timesheet have successfully rejected."
      end
    end

    def approvefm
      respond_to :html, :js
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.status_timesheet_id == 4 # Approve by PM
        @timesheet_task.update(status_timesheet_id: 6)
        flash.now[:success] = "Timesheet have successfully approved."
      end
    end

    def rejectfm
      respond_to :html, :js
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.status_timesheet_id == 4 # Reject by PM
        @timesheet_task.update(status_timesheet_id: 5)
        flash.now[:success] = "Timesheet have successfully rejected."
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
      @timesheet_tasks = TimesheetTask.where(employee_id: current_user.employee.id).order("date desc")
      @backup_lists = @timesheet_tasks
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def timesheet_task_params
        params.require(:timesheet_task).permit(:employee_id, :project_id, :activity, :date, :working_hours, :site_name, :project_region_id, :vehicle_number, :vehicle_owner_id, :holiday, :attachment_link)
    end
      
      
  end