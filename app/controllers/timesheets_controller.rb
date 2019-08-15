class TimesheetsController < ApplicationController
    include ApplicationHelper
    
    before_action :require_login
  
    def index
      
      respond_to :html, :js
      @tmsheets = current_user.employee.timesheets.order("created_at desc") if current_user.employee

    end
  
    # GET /registers/1/edit
    def edit
    end
  
    # POST /registers
    def create
    end
  
    # PATCH/PUT /registers/1
    def update
    end
  
    # DELETE /registers/1
    # DELETE /registers/1.json
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
        params.require(:leave).permit(:full_name, :first_name, :last_name, :phone_number, :phone_number_2, :identity_number, :category, :drawing_chance, :info_1, :info_2, :info_3, :info_4, :info_5, :attendance)
    end
      
  end
  