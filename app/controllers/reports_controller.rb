class ReportsController < ApplicationController
    before_action :logged_in?
    before_action :permitted_report?

    def index
        respond_to :html, :js
    end
  
    def employee
        respond_to :html, :js
        params[:year] = Date.today.year if params[:year].nil?
        params[:month]  = Date.today.month if params[:month].nil?
        @year = params[:year].to_i
        @month = params[:month].to_i
        params[:project_status] = 0
        @employees = Employee.where(search_employee_params)
        if current_user.webrole.role == "Manager"
            params[:project_id] = Project.where(manager_id: current_user.employee.id).pluck(:id)
            @employees = @employees.where(project_id: params[:project_id])
            @employee_lists = Employee.where(project_id: params[:project_id]).pluck(:full_name, :id)
            @project_lists = Project.where(manager_id: current_user.employee.id).pluck(:name, :id)     
        else
            @project_lists = Project.all.pluck(:name, :id)
            @employee_lists = Employee.all.pluck(:full_name, :id)
        end
    end

    def project
        respond_to :html, :js
        params[:year] = Date.today.year if params[:year].nil?
        params[:month]  = Date.today.month if params[:month].nil?
        @year = params[:year].to_i
        @month = params[:month].to_i
        params[:project_status] = 0
        if current_user.webrole.role == "Manager"
            params[:manager_id] = current_user.employee.id
            @project_lists = Project.where(manager_id: current_user.employee.id).pluck(:name, :id)
        else
            @project_lists = Project.all.pluck(:name, :id)
        end
        @projects = Project.where(search_project_params)
    end

    def leave
        respond_to :html, :js
        params[:year] = Date.today.year if params[:year].nil?
        params[:month] = Date.today.month if params[:month].nil?
        @year = params[:year].to_i
        @month = params[:month].to_i
        @leaveaps = Leaveap.where("DATE_PART('year', from_date) = ? and DATE_PART('month', from_date) = ?", @year, @month)
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
      params.permit(:id, :project_id, :department_id).delete_if {|key, value| value.blank? }
    end

    def search_project_params
        params.permit(:id, :manager_id, :manager_alt_id).delete_if {|key, value| value.blank? }
    end

    def search_leave_params
        params.permit(:id, :manager_id, :manager_alt_id).delete_if {|key, value| value.blank? }
    end

  end