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

    def show
      respond_to :html, :js
    end
  
    # GET /employees/1/edit
    def edit
      respond_to :html, :js
      @employee = Employee.find(params[:id])
    end
  
    # POST /employees
    def create
      respond_to :html, :js
      @employee = Employee.new(employee_params)
      if @employee.save
        flash.now[:success] = "New Employee have been successfully created."
      else
        flash.now[:warning] = @employee.errors.full_messages
      end
      @employees = Employee.all.order("created_at desc")
    end
  
    # PATCH/PUT /employees/1
    def update
      respond_to :html, :js
      @employee = Employee.find(params[:id])
      if @employee.update(employee_params)
        flash.now[:success] = "Employee Information have been successfully updated."
        @employees = Employee.all.order("created_at desc")
      else
        flash.now[:warning] = @employee.errors.full_messages
      end
    end
  
    # DELETE /employees/1
    # DELETE /employees/1.json
    def destroy
      respond_to :html, :js
      @employee = Employee.find(params[:id])
      if @employee.destroy
        flash.now[:success] = "Employee have been successfully removed."
        @employees = Employee.all.order("created_at desc")
      else
        flash.now[:warning] = "This action couldn't be performed due to error, please check with admin."
      end
    end
  
    private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
        params.require(:employee).permit(:full_name, :first_name, :last_name, :personal_email, :company_email, :marital_status, :spouse_name, :category, :employee_id, :position, :phone_number, :phone_number_2, :address, :address_2, :nationality, :race, :identity_passport_no, :birthday, :joined_since, :joined_last, :base_salary, :annual_leave_entitled, :annual_leave_taken, :medical_leave_entitled, :medical_leave_taken, :contract_start, :contract_end, :bank_name, :bank_account)
    end
      
  end