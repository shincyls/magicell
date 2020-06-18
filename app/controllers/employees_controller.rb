class EmployeesController < ApplicationController
    before_action :logged_in?
    before_action :verify_authenticity_token
  
    def index
      respond_to :html, :js
      if params[:value].present?
        @employees = Employee.where(employment_status: params[:value].to_i).order("created_at desc")
      else
        @employees = Employee.all.order("created_at desc")
      end
    end

    def summary
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

    def update_leaves
      respond_to :html, :js
      Employee.update_leaves(params[:year].to_i)
      flash.now[:success] = "Done!"
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
      index
    end

    def message
      respond_to :js
    end

    def approve_timesheet
      @timesheet_tasks = TimesheetTask.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_timesheet_id = ? and employee_id = ?", params[:year], params[:month], 2, params[:id])
      items = @timesheet_tasks.count
      if @timesheet_tasks.update(status_timesheet_id: 6)
        flash.now[:success] = "#{items} timesheet task(s) have been approved."
      end
      @employee = Employee.find(params[:id])
      @year = params[:year].to_i
      @month = params[:month].to_i
      render :message
    end

    def approve_expense
      @expense_lists = ExpenseList.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_expense_id = ? and employee_id = ?", params[:year], params[:month], 2, params[:id])
      lists = @expense_lists.count
      if @expense_lists.update(status_expense_id: 4)
        flash.now[:success] = "#{lists} items have been approved."
      end
      render :message
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