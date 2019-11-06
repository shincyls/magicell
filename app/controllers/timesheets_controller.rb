class TimesheetsController < ApplicationController
    include ApplicationHelper
    before_action :require_login
  
    def index
      respond_to :html, :js
      @timesheets = current_user.employee.timesheets.order("date desc") if current_user.employee
      @timesheets = @timesheets.year_month(Date.today.year,Date.today.month)
      @session = Date.today.strftime("%Y-%b")
      @timesheet = Timesheet.new
    end

    def new
      respond_to :html, :js
      @timesheet = Timesheet.new
    end
  
    # POST /timesheets
    def create
      @timesheet = Timesheet.new(timesheet_params)
      unless Timesheet.exists?(employee_id: @timesheet.employee_id, year: @timesheet.year, month: @timesheet.month)
        if @timesheet.save
          flash.now[:success] = "Your Timesheet for #{@timesheet.session} has successfully created."
        end
      else
        flash.now[:warning] = "Your Timesheet for #{@timesheet.session} is already exist."
      end
    end

    # GET /timesheets/1/edit
    def edit
      respond_to :html, :js
      @timesheet = Timesheet.find(params[:id])
    end
    
    # GET /timesheets/1
    def show
    end
    
    # PATCH/PUT /timesheets/1
    def update
      respond_to :html, :js
      @timesheet = Timesheet.new(timesheet_params)
      unless Timesheet.exists?(employee_id: @timesheet.employee_id, project_id: @timesheet.project_id, timesheet_category_id: @timesheet.timesheet_category_id, year: @timesheet.year, month: @timesheet.month)
        @timesheet = Timesheet.find(params[:id])
        if @timesheet.update(timesheet_params)
          flash.now[:success] = "Your Timesheet for #{@timesheet.session} has successfully updated."
        end
      else
        flash.now[:warning] = "Your Timesheet for #{@timesheet.session} is already exist."
      end
    end
  
    # DELETE /timesheets/1
    # DELETE /timesheets/1.json
    def destroy
      respond_to :html, :js
      @timesheet = Timesheet.find(params[:id])
      if @timesheet.destroy
        flash.now[:success] = "Timesheet have been remove."
      else
        flash.now[:warning] = "This action couldn't performed due to error, please check with admin."
      end
    end

    # GET /timesheets/1/taskadd
    def taskadd
      respond_to :html, :js
      @timesheet = Timesheet.find(params[:id])
      @task = TimesheetTask.new
    end

    # GET /timesheets/1/taskadd
    def approvaladd
      respond_to :html, :js
      @timesheet = Timesheet.find(params[:id])
      @timesheet_approval = TimesheetApproval.new
    end

    # POST /timesheets/1/submit
    def submit
      respond_to :html, :js
      @timesheet = Timesheet.find(params[:id])
      if @timesheet.submitted
        flash.now[:alert] = "Your Timesheet is already submitted."
      else
        # Get All Unique Projects and Create Task Approval for each unique Manager
        @projects = TimesheetTask.where(timesheet_id: @timesheet.id).pluck(:project_id).uniq!
        @projects.each do |p|
          @manager = Project.find(p).manager
          unless TimesheetApproval.exists?(timesheet_id: @timesheet.id, employee_id: @timesheet.employee_id, manager_id: @manager.id)
            @timesheet_approval = TimesheetApproval.new(timesheet_id: @timesheet.id, employee_id: @timesheet.employee_id, manager_id: @manager.id)
          else # If Approval is already Exist then it is resubmit, then reset reject status
            @timesheet_approval = TimesheetApproval.find_by(timesheet_id: @timesheet.id, employee_id: @timesheet.employee_id, manager_id: @manager.id)
            @timesheet_approval.reject = false
          end
          # Send Email Notification to Manager once saved
          if @timesheet_approval.save
            UserMailer.submit_timesheet(@timesheet_approval.id).deliver
          end
        end
        if @timesheet.update(submitted: true)
          flash.now[:success] = "Your Timesheet have been succesfully submitted."
        end
      end
      @timesheet_approval = current_user.employee.emp_timesheet_approvals
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
    def timesheet_params
      params.require(:timesheet).permit(:employee_id, :timesheet_category_id, :project_id, :year, :month)
    end

    def no_duplicate
      @timesheet = Timesheet.find(params[:id])
      if Timesheet.exists?(employee_id: @timesheet.employee.id, project_id: @timesheet.project_id, year: @timesheet.year, month: @timesheet.month)
        return false
      else
        return true
      end
    end
      
  end