class EmployeesController < ApplicationController
    before_action :logged_in?
  
    def index
      respond_to :html, :js
      if params[:value].present?
        @employees = Employee.where(employment_status: params[:value].to_i).order("created_at desc")
      else
        @employees = Employee.all.order("created_at desc")
      end
    end

    def new
      respond_to :html, :js
      @employee = Employee.new
    end

    def show
      respond_to :html, :js
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

    # GET /employees/1/edit
    def edit
      respond_to :html, :js
      @employee = Employee.find(params[:id])
    end

    def editself
      respond_to :html, :js
      @employee = current_user.employee
    end
  
    # PATCH/PUT /employees/1
    def update
      respond_to :html, :js
      @employee = Employee.find(params[:id])
      if @employee.update(employee_params)
        flash.now[:success] = "Employee Information have been successfully updated."
        # Automatic Update Webrole as Manager
        if (@employee.employee_position.position == "Manager") & (@employee.user)
          @user = @employee.user
          if @user.webrole_id == 2
            @user.webrole_id = Webrole.find_by(role: "Manager").id
          end
          @user.save
        end
        @employees = Employee.all.order("created_at desc")
      else
        flash.now[:warning] = @employee.errors.full_messages
      end
    end

    def updateself
      respond_to :html, :js
      @employee = Employee.find(params[:id])
      if @employee.update(employee_params)
        flash.now[:success] = "Employee Information have been successfully updated."
        # Automatic Update Webrole as Manager
        if (@employee.employee_position.position == "Manager") & (@employee.user)
          @user = @employee.user
          if @user.webrole_id == 2
            @user.webrole_id = Webrole.find_by(role: "Manager").id
          end
          @user.save
        end
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

    def import
      respond_to :html, :js
      if params[:file].present?
        Employee.import(params[:file])
        flash.now[:success] = "Import Done."
      else
        flash.now[:danger] = "Import File is not found."
      end
    end
  
    private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def employee_params
        params.require(:employee).permit(
          :department_id, :project_id, :company_id, :employee_position_id, :full_name, :personal_email, :company_email, 
          :employee_code, :job_title, :phone_number, :phone_emergency, :address, :address_2, :nationality, :race, :identity_no, :bank_name, 
          :bank_account, :epf_account, :lhdn_account, :medical_account, :insurance_account, :marital_status, :spouse_name, :children_count, 
          :birthday, :joined_since, :joined_last, :base_salary, :fix_allowance, 
          :annual_leave_entitled, :annual_leave_taken, :medical_leave_entitled, :medical_leave_taken, :contract_start, :contract_end, :category, :employment_status,
          :phone_number_emergency, :gender, :socso_account, :include_socso, :include_epf
        )
    end
      
  end