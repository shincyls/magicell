class TimesheetsController < ApplicationController
    include ApplicationHelper
    before_action :require_login
  
    def index
      respond_to :html, :js
      @timesheets = current_user.employee.timesheets.order("date desc") if current_user.employee
      # @history = @timesheets.collect {|l| l.date.strftime("%Y-%b")}.uniq
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
      unless Timesheet.exists?(employee_id: @timesheet.employee_id, project_id: @timesheet.project_id, timesheet_category_id: @timesheet.timesheet_category_id, year: @timesheet.year, month: @timesheet.month)
        if @timesheet.save
          flash.now[:success] = "Your Timesheet for #{@timesheet.project.name} (#{@timesheet.timesheet_category.name}) #{@timesheet.year}-#{@timesheet.month} has successfully created."
        end
      else
        flash.now[:warning] = "Your Timesheet for #{@timesheet.project.name} (#{@timesheet.timesheet_category.name}) #{@timesheet.year}-#{@timesheet.month} is already exist."
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
          flash.now[:success] = "Your Timesheet for #{@timesheet.project.name} (#{@timesheet.timesheet_category.name}) #{@timesheet.year}-#{@timesheet.month} has successfully updated."
        end
      else
        flash.now[:warning] = "Your Timesheet for #{@timesheet.project.name} (#{@timesheet.timesheet_category.name}) #{@timesheet.year}-#{@timesheet.month} is already exist."
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
        flash.now[:success] = "Your Timesheet is already submitted."
      elsif (@timesheet.timesheet_approvals.count <= 0)
        flash.now[:warning] = "Your must enter at least 1 Manager Approval."
      else
        if @timesheet.update(submitted: true)
          flash.now[:success] = "Your Timesheet have been succesfully submitted."
        end
      end
      @timesheet_approval = TimesheetApproval.new
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


  # def create2
    #   respond_to :html, :js
    #   date_now = Date.parse(params["timesheet"][:multi_date_from])
    #   date_end = Date.parse(params["timesheet"][:multi_date_to])
    #   params["timesheet"].delete("multi_date_from")
    #   params["timesheet"].delete("multi_date_to")
      
    #   while date_end >= date_now
    #     unless date_now.saturday? or date_now.sunday?
    #       @timesheet = Timesheet.new(timesheet_params)
    #       unless Timesheet.exists?(employee_id: @timesheet.employee.id, date: date_now)
    #         @timesheet.date = date_now
    #         @timesheet.save
    #       else
    #         @timesheet = Timesheet.find_by(employee_id: @timesheet.employee.id, date: date_now)
    #         @timesheet.update(timesheet_params)
    #       end
    #     end
    #     date_now += 1.day
    #   end
    #   flash.now[:success] = "Your Timesheet have been created."
    #   @timesheets = current_user.employee.timesheets.order("date desc").year_month(Date.today.year,Date.today.month)
  # end