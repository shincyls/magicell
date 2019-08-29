class TimesheetsController < ApplicationController
    include ApplicationHelper
    before_action :require_login
  
    def index
      respond_to :html, :js
      @timesheets = current_user.employee.timesheets.order("date desc") if current_user.employee
      # @history = @timesheets.collect {|l| l.date.strftime("%Y-%b")}.uniq
      @timesheets = @timesheets.year_month(Date.today.year,Date.today.month)
      @month = Date.today.month
      @timesheet = Timesheet.new
    end
  
    # GET /timesheets/1/edit
    def edit
    end
  
    # POST /timesheets
    def create
      respond_to :html, :js
      @id = []
      date_now = Date.parse(params["timesheet"][:multi_date_from])
      date_end = Date.parse(params["timesheet"][:multi_date_to])
      params["timesheet"].delete("multi_date_from")
      params["timesheet"].delete("multi_date_to")

      while date_end >= date_now
        unless date_now.saturday? or date_now.sunday?
          @timesheet = Timesheet.new(timesheet_params)
          #Prevent Duplicate
          unless Timesheet.exists?(employee_id: @timesheet.employee_id, date: date_now)
            @timesheet.date = date_now
            @timesheet.save
            @id.append(@timesheet.id)
            flash.now[:success] = "Your Timesheet have been created."
          end
        end
        date_now = date_now + 1.day
      end
      @timesheets = Timesheet.where(id: @id)
    end
  
    # PATCH/PUT /timesheets/1
    def update
    end
  
    # DELETE /timesheets/1
    # DELETE /timesheets/1.json
    def destroy
    end

    def retrieve
      respond_to :html, :js
      @year = params[:button].to_date.year
      @month = params[:button].to_date.month
      @timesheets = current_user.employee.timesheets.year_month(@year,@month).order("date desc") if current_user.employee
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
        params.require(:timesheet).permit(:employee_id, :timesheet_category_id, :project_id, :site_name, :activity, :location, :date, :time_in, :time_out, :time_break)
    end
      
  end