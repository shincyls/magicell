class TimesheetTasksController < ApplicationController
    before_action :logged_in?
    before_action :return_default, only: [:index, :project, :finance]
    after_action :return_employee, only: [:create]
    skip_before_action :verify_authenticity_token, only: [:submitall, :approvepmall, :approvefmall]

    def index
      respond_to :html, :js
      @timesheet_task = TimesheetTask.new
      if @status == 0
        @timesheet_tasks = current_user.employee.timesheet_tasks.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ?", @year, @month)
      else
        @timesheet_tasks = current_user.employee.timesheet_tasks.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_timesheet_id = ?", @year, @month, @status)
      end

    end

    def summary
      respond_to :html, :js
      @timesheet_tasks = TimesheetTask.where(status_timesheet_id: [2,3,4,5,6]).order("created_at desc")
    end

    def project
      respond_to :html, :js
      @projects = Project.where(manager_id: current_user.employee.id).pluck(:id)
      @timesheet_tasks = TimesheetTask.where(project_id: @projects, status_timesheet_id: [2,3,4,5,6])
      if @status == 0
        @timesheet_tasks = @timesheet_tasks.where("
          DATE_PART('year', date) >= ? and 
          DATE_PART('year', date) <= ? and 
          DATE_PART('month', date) >= ? and 
          DATE_PART('month', date) <= ? and 
          status_timesheet_id = ?
          ", @yearb, @year, @monthb, @month, 2)
      elsif @status < 9
        @timesheet_tasks = @timesheet_tasks.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_timesheet_id = ?", @year, @month, @status)
      end
    end

    def finance
      respond_to :html, :js
      @timesheet_tasks = TimesheetTask.where(status_timesheet_id: [4,5,6])
      if @status == 0
        @timesheet_tasks = @timesheet_tasks.where("
          DATE_PART('year', date) >= ? and 
          DATE_PART('year', date) <= ? and 
          DATE_PART('month', date) >= ? and
          DATE_PART('month', date) <= ? and
          status_timesheet_id = ?
          ", @yearb, @year, @monthb, @month, 4)
      elsif @status < 9
        @timesheet_tasks = @timesheet_tasks.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_timesheet_id = ?", @year, @month, @status)
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
      @timesheet_tasks = []
      message = ""
      date_now = Date.parse(params["timesheet_task"][:multi_date_from])
      date_end = Date.parse(params["timesheet_task"][:multi_date_to])
      if params["timesheet_task"][:exclude_weekend] == "1"
        weekend_filter = true
      else
        weekend_filter = false
      end
      params["timesheet_task"].delete("multi_date_from")
      params["timesheet_task"].delete("multi_date_to")
      while date_end >= date_now
        @timesheet_task = TimesheetTask.new(timesheet_task_params)
        @timesheet_task.date = date_now
        unless @timesheet_task.holiday? and @timesheet_task.allowed_edit? and weekend_filter
          unless TimesheetTask.exists?(employee_id: @timesheet_task.employee_id, date: date_now)
            if @timesheet_task.save
              @timesheet_tasks << @timesheet_task
              flash.now[:success] = "Your Timesheet have been added#{message}."
            else
              flash.now[:warning] = @timesheet_task.errors.full_messages
            end
          else # Update/Overwrite
            message = ", but tasks with duplicated date are ignored"
          end
        end
        date_now += 1.day
      end
      if message.empty?
        flash.now[:success] = "Your Timesheet have been added."
      else
        flash.now[:warning] = "Done, but some tasks with existed date are not added."
      end
      render 'datarow'
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
      render 'datarow'
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
      render 'datarow'
    end

    def submit
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.status_timesheet_id == 1
        @timesheet_task.update(status_timesheet_id: 2, submitted_at: Time.now)
      elsif @timesheet_task.status_timesheet_id == 3
        @timesheet_task.update(status_timesheet_id: 2)
      elsif @timesheet_task.status_timesheet_id == 5
        @timesheet_task.update(status_timesheet_id: 4)
      end
      render 'datarow'
    end

    def submitall
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
      render 'datarow'
    end

    def approvepmall
      @receive = JSON.parse params[:ids]
      @projects = Project.where(manager_id: current_user.employee.id).pluck(:id)
      @count = TimesheetTask.where(id: @receive, status_timesheet_id: 2, project_id: @projects).update_all("status_timesheet_id = 4")
      flash.now[:success] = "#{@count} Pending Item(s) have been successfully approved."
      @timesheet_tasks = TimesheetTask.where(id: @receive)
      render 'datarow'
    end
  
    def approvefmall
      @receive = JSON.parse params[:ids]
      count = TimesheetTask.where(id: @receive, status_timesheet_id: 4).update_all("status_timesheet_id = 6")
      flash.now[:success] = "#{count} Pending Item(s) have been successfully approved."
      @timesheet_tasks = TimesheetTask.where(id: @receive)
      render 'datarow'
    end

    # Approve Single Timesheet Task
    def approvepm
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.status_timesheet_id == 2 # Pending PM
        @timesheet_task.update(status_timesheet_id: 4)
        flash.now[:success] = "Timesheet have been approved by PM."
      end
      render 'datarow'
    end
    def approvefm
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.status_timesheet_id == 4 # Pending FM
        @timesheet_task.update(status_timesheet_id: 6)
        flash.now[:success] = "Timesheet have been approved by FM."
      end
      render 'datarow'
    end
    def rejectpm
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.status_timesheet_id == 2 # Pending PM
        @timesheet_task.update(status_timesheet_id: 3)
        flash.now[:success] = "Timesheet have been rejected by PM."
      end
      render 'datarow'
    end
    def rejectfm
      @timesheet_task = TimesheetTask.find(params[:id])
      if @timesheet_task.status_timesheet_id == 4 # Pending FM
        @timesheet_task.update(status_timesheet_id: 5)
        flash.now[:success] = "Timesheet have been rejected by FM."
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
      @timesheet_tasks = TimesheetTask.where(employee_id: current_user.employee.id).order("date desc")
      @backup_lists = @timesheet_tasks
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
    def timesheet_task_params
        params.require(:timesheet_task).permit(:employee_id, :project_id, :activity, :date, :working_hours, :site_name, :project_region_id, :vehicle_number, :vehicle_owner_id, :holiday, :attachment_link)
    end
      
      
  end