class ReportsController < ApplicationController
    before_action :logged_in?
    before_action :permitted_report?, except: [:employee_timesheets, :employee_details]

    def index
        respond_to :html, :js
    end
  
    def employee
        respond_to :html, :js
        params[:year] = Date.today.year if params[:year].nil?
        params[:month] = Date.today.month if params[:month].nil?
        params[:status] = 6 if params[:status].nil?
        params[:employment_status] = 0
        @year = params[:year].to_i
        @month = params[:month].to_i
        @status = params[:status].to_i
        @employees = Employee.where(search_employee_params)
        if current_user.webrole.role == "Manager"
            params[:project_id] = Project.where(manager_id: current_user.employee.id).pluck(:id)
            @employees = @employees.where(project_id: params[:project_id])
            @employee_lists = Employee.where("project_id = ? and employment_status = ?", params[:project_id], 0).pluck(:full_name, :id)
            @project_lists = Project.where("manager_id = ? and project_status = ?", current_user.employee.id, 0).pluck(:name, :id)     
        else
            @project_lists = Project.where("project_status = ?", 0).pluck(:name, :id)
            @employee_lists = Employee.where("employment_status = ?", 0).pluck(:full_name, :id)
        end
    end


    def employee_timesheets
        respond_to :html, :js
        params[:year] = Date.today.year if params[:year].nil?
        params[:month] = Date.today.month if params[:month].nil?
        params[:status] = 6 if params[:status].nil?
        params[:employment_status] = 0
        @year = params[:year].to_i
        @month = params[:month].to_i
        @status = params[:status].to_i
        @employees = Employee.where(search_employee_params)
        if current_user.webrole.role == "Manager"
            params[:project_id] = Project.where(manager_id: current_user.employee.id).pluck(:id)
            @employees = @employees.where(project_id: params[:project_id])
            @employee_lists = Employee.where("project_id = ? and employment_status = ?", params[:project_id], 0).pluck(:full_name, :id)
            @project_lists = Project.where("manager_id = ? and project_status = ?", current_user.employee.id, 0).pluck(:name, :id)     
        else
            @project_lists = Project.where("project_status = ?", 0).pluck(:name, :id)
            @employee_lists = Employee.where("employment_status = ?", 0).pluck(:full_name, :id)
        end
    end

    def employee_details
        respond_to :html, :js
        @year = params[:year].to_i
        @month = params[:month].to_i
        @status = params[:status].to_i
        @employee = Employee.find(params[:id])
        @timesheet_tasks = @employee.timesheet_tasks.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_timesheet_id >= ?", @year, @month, @status)
        @expense_lists = @employee.expense_lists.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_expense_id >= ?", @year, @month, @status)
        @leaveaps = @employee.leaveaps.where("DATE_PART('year', from_date) = ? and DATE_PART('month', from_date) = ?  and status_leave_id >= ?", @year, @month, @status-2)
    end

    def project
        respond_to :html, :js
        params[:year] = Date.today.year if params[:year].nil?
        params[:month] = Date.today.month if params[:month].nil?
        params[:status] = 6 if params[:status].nil?
        params[:project_status] = 0
        @year = params[:year].to_i
        @month = params[:month].to_i
        @status = params[:status].to_i
        if current_user.webrole.role == "Manager"
            params[:manager_id] = current_user.employee.id
            @project_lists = Project.where("manager_id = ? and project_status =?", current_user.employee.id, 0).pluck(:name, :id)
        else
            @project_lists = Project.where("project_status = ?", 0).pluck(:name, :id)
        end
        @projects = Project.where(search_project_params)
    end

    def project_details
        respond_to :html, :js
        @year = params[:year].to_i
        @month = params[:month].to_i
        @status = params[:status].to_i
        @project = Project.find(params[:id])
        @timesheet_tasks = @project.timesheet_tasks.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_timesheet_id >= ?", @year, @month, @status)
        @expense_lists = @project.expense_lists.where("DATE_PART('year', date) = ? and DATE_PART('month', date) = ? and status_expense_id >= ?", @year, @month, @status)
    end

    def leave
        respond_to :html, :js
        params[:year] = Date.today.year if params[:year].nil?
        params[:month] = Date.today.month if params[:month].nil?
        params[:status] = 4 if params[:status].nil?
        @year = params[:year].to_i
        @month = params[:month].to_i
        @status = params[:status].to_i
        @leaveaps = Leaveap.where("DATE_PART('year', from_date) = ? and DATE_PART('month', from_date) = ? and status_leave_id >= ?", @year, @month, @status)
    end

    def expense
    end

    def vehicle
        respond_to :html, :js
    end

    def company
        respond_to :html, :js
        @companies = Company.all
    end

    private

    def search_employee_params
      params.permit(:id, :project_id, :department_id, :employment_status).delete_if {|key, value| value.blank? }
    end

    def search_project_params
        params.permit(:id, :manager_id, :manager_alt_id, :project_status).delete_if {|key, value| value.blank? }
    end

    def search_leave_params
        params.permit(:id, :manager_id, :manager_alt_id).delete_if {|key, value| value.blank? }
    end

  end