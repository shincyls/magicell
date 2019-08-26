class TimesheetsController < ApplicationController
    include ApplicationHelper
    
    before_action :require_login
  
    def index
      respond_to :html, :js
      @timesheets = current_user.employee.timesheets.order("created_at desc") if current_user.employee
      @timesheet = Timesheet.new
    end
  
    # GET /timesheets/1/edit
    def edit
    end
  
    # POST /timesheets
    def create
      respond_to :html, :js
      @timesheet = Timesheet.new(timesheet_params)
      @timesheet.save
      @timesheets = Timesheet.where(id: @timesheet.id)
    end
  
    # PATCH/PUT /timesheets/1
    def update
    end
  
    # DELETE /timesheets/1
    # DELETE /timesheets/1.json
    def destroy
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
        params.require(:timesheet).permit(:employee_id, :timesheet_category_id, :project_id, :site_name, :location, :date, :time_in, :time_out, :time_break, :apv_mgr_1_id, :apv_mgr_2_id)
    end
      
  end