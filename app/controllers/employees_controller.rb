class EmployeesController < ApplicationController
    before_action :logged_in?
  
    def index
      respond_to :html, :js
      @employees = Employee.all.order("created_at desc")
    end

    def new
      respond_to :html, :js
      @employee = Employee.new
    end
  
    # GET /employees/1/edit
    def edit
    end
  
    # POST /employees
    def create
      respond_to :html, :js
      @employee = Employee.new(employee_params)
      @employee.save
      @user = User.new(employee_id: @employee.id, username: @employee.company_email.split("@")[0])
      @user.save
      flash.now[:success] = "New Employee #{@employee.company_email} have been successfully created."
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
        params.require(:employee).permit(:first_name, :last_name, :company_email, :employee_id, :position, :phone_number, :phone_number_2, :address, :address_2, :nationality, :race, :identity_passport_no, :birthday, :joined_since, :joined_last, :base_salary, :annual_leave_entitled, :annual_leave_taken, :medical_leave_entitled, :medical_leave_taken, :contract_start, :contract_end)
    end
      
  end