class EmployeesController < ApplicationController
    before_action :logged_in?
  
    def index
      respond_to :html, :js
      @employees = Employee.all.order("created_at desc")
    end

    def new
      respond_to :html, :js
    end
  
    # GET /employees/1/edit
    def edit
    end
  
    # POST /employees
    def create
      respond_to :html, :js
    end
  
    # PATCH/PUT /employees/1
    def update
    end
  
    # DELETE /employees/1
    # DELETE /employees/1.json
    def destroy
      respond_to :html, :js
    end
  
    private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
        params.require(:employee).permit(:reason, :employee_id, :apv_mgr_1_id, :apv_mgr_2_id, :leavetype_id, :contact_person, :contact_number, :from_date, :to_date, :from_ampm, :to_ampm, :confirm)
    end
      
  end