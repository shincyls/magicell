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
  
    # POST /timesheets
    def create
      respond_to :html, :js
      date_now = Date.parse(params["timesheet"][:multi_date_from])
      date_end = Date.parse(params["timesheet"][:multi_date_to])
      params["timesheet"].delete("multi_date_from")
      params["timesheet"].delete("multi_date_to")

      while date_end >= date_now
        unless date_now.saturday? or date_now.sunday?
          @timesheet = Timesheet.new(timesheet_params)
          unless Timesheet.exists?(employee_id: @timesheet.employee.id, date: date_now)
            @timesheet.date = date_now
            @timesheet.save
          else
            @timesheet = Timesheet.find_by(employee_id: @timesheet.employee.id, date: date_now)
            @timesheet.update(timesheet_params)
          end
        end
        date_now += 1.day
      end
      flash.now[:success] = "Your Timesheet have been created."
      @timesheets = current_user.employee.timesheets.order("date desc").year_month(Date.today.year,Date.today.month)
    end

    # GET /timesheets/1
    def show
    end

    # GET /timesheets/1/edit
    def edit
      @timesheet = Timesheet.find(params[:id])
    end
  
    # PATCH/PUT /timesheets/1
    def update
      respond_to :html, :js
      @timesheet = Timesheet.find(params[:id])
      if @timesheet.update(timesheet_params)
        flash.now[:success] = "Timesheet's entry have been updated."
        @timesheets = current_user.employee.timesheets.order("date desc").year_month(@timesheet.date.year,@timesheet.date.month)
      else
        flash.now[:success] = "This action couldn't performed due to error, please check with admin."
      end
    end
  
    # DELETE /timesheets/1
    # DELETE /timesheets/1.json
    def destroy
      respond_to :html, :js
      @timesheet = Timesheet.find(params[:id])
      if @timesheet.destroy
        flash.now[:success] = "Timesheet's entry have been removed."
        @timesheets = current_user.employee.timesheets.order("date desc").year_month(@timesheet.date.year,@timesheet.date.month)
      else
        flash.now[:warning] = "This action couldn't performed due to error, please check with admin."
      end
    end

    def retrieve
      respond_to :html, :js
      @session = params[:button]
      @timesheets = current_user.employee.timesheets.year_month(@session.to_date.year, @session.to_date.month).order("date desc") if current_user.employee
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
        params.require(:timesheet).permit(:id, :employee_id, :timesheet_category_id, :project_id, :site_name, :activity, :location, :date, :time_in, :time_out, :time_break)
    end
      
  end