class MagicnetsController < ApplicationController
    include ApplicationHelper

    # before_action :logged_in?, except: :login
    def dashboard
      respond_to :html, :js
      redirect_to login_path unless logged_in?
    end

    def login
      respond_to :html, :js
      redirect_to dashboard_url if logged_in?
    end

    # Quick Link to Approve Leave
    def approve_leave
      respond_to :html, :js
      if logged_in?
        if Leaveap.exists?(id: params[:id])
          @leaveap = Leaveap.find(params[:id])
          @employee = @leaveap.employee
          @proceed = false

          # Check If Approved Before
          if params[:approval] == "1"
            if @leaveap.apv_1 == false
              if @leaveap.apv_mgr_1_id == current_user.employee.id
                @leaveap.apv_1 = true
                @proceed = true
              else
                @message = "Invalid Manager for this Leave Application."
              end
            end
          elsif params[:approval] == "2"
            if @leaveap.apv_2 == false
              if @leaveap.apv_mgr_2_id == current_user.employee.id
                @leaveap.apv_2 = true
                @proceed = true
              else
                @message = "Invalid Manager for this Leave Application."
              end
            end
          else
            @message = "Invalid Approval ID."
          end

          # If Continue
          if @proceed
            if check_leave_remaining?
              if @leaveap.approve_sum # If all manager approved
                @leaveap.status_leave_id = 4
                if @leaveap.leavetype_id == 1 # Annual Leave
                  @employee.annual_leave_taken += @leaveap.total_days
                elsif @leaveap.leavetype_id == 2 # Medical Leave
                  @employee.medical_leave_taken += @leaveap.total_days
                end
                @employee.save
              else
                @leaveap.status_leave_id = 2
              end
              if @leaveap.save
                @message = "You have approved leave application, notification has sent to applicant."
                UserMailer.approve_leave(@leaveap.id, params[:value]).deliver
              end
            end
          else
            @message = "Leave Application have been approved before."
          end
        else
          @message = "Leave Application ID is not exist."
        end
      else
        @message = "You must be logged in to proceed this action."
      end
    end

    # Dashboards for each role
    # Employee Pages
    def dashemployee
      respond_to :js
      @employee = current_user.employee
      render template: "magicnets/view_emp/dashemployee"
    end

    # Load The Page
    def timesheetemployee
      respond_to :js
      render template: "magicnets/view_emp/timesheetemployee"
    end

    def expenseemployee
      respond_to :js
      render template: "magicnets/view_emp/expenseemployee"
    end

    # Finance Pages
    def dashfinance
      respond_to :js
      render template: "magicnets/view_fin/dashfinance"
    end

    def finance_timesheet
      respond_to :html, :js
      @timesheets = Timesheet.where(submitted: true)
      render template: "magicnets/view_fin/finance_timesheet"
    end

    # HR Pages
    def dashhr
      respond_to :js
      render template: "magicnets/view_hr/dashhr"
    end

    def taskhr
      respond_to :js
      render template: "magicnets/view_hr/taskhr"
    end

    # PM Pages
    def dashpm
      respond_to :js
      @projects = Project.where(manager_id: current_user.employee.id)
      render template: "magicnets/view_pm/dashpm"
    end

    def leave_approval
      respond_to :js
      @leaveaps = (Leaveap.where(apv_mgr_1_id: current_user.employee.id, status_leave_id: [2,3,4]) + Leaveap.where(apv_mgr_2_id: current_user.employee.id, status_leave_id: [2,3,4])).uniq
      render template: "magicnets/view_pm/leave_approval"
    end

    def timesheet_approval
      respond_to :html, :js
      @timesheets = TimesheetApproval.where(manager_id: current_user.employee.id).joins("LEFT JOIN timesheets on timesheet_approvals.timesheet_id = timesheets.id").where("timesheets.submitted = ?", true)
      render template: "magicnets/view_pm/timesheet_approval"
    end

    def expense_approval
      respond_to :html, :js
      @expenses = ExpenseApproval.where(manager_id: current_user.employee.id).joins("LEFT JOIN expenses on expense_approvals.expense_id = expenses.id").where("expenses.submitted = ?", true)
      render template: "magicnets/view_pm/expense_approval" 
    end

    # IT Pages
    def dashit
      respond_to :js
      render template: "magicnets/view_it/dashit"
    end

    def webrole
      respond_to :js
      render template: "magicnets/view_it/webrole"
    end

    def account
      respond_to :js
      render template: "magicnets/view_it/account"
    end

    # private

    def check_leave_remaining?
      if @leaveap.leavetype_id == 1 # Annual Leave
        remaining = (@employee.annual_leave_taken + @leaveap.days) - @employee.annual_leave_entitled
        if remaining > 0
          flash.now[:danger] = "Application has exceeded applicant's entitled Annual Leave for #{remaining} day(s)."
          return false
        else
          return true
        end
      elsif @leaveap.leavetype_id == 2 # Medical Leave
        remaining = (@employee.medical_leave_taken + @leaveap.days) - @employee.medical_leave_entitled
        if remaining > 0
          flash.now[:danger] =  "Application has exceeded applicant's entitled Medical Leave for #{remaining} day(s)."
          return false
        else
          return true
        end
      else
        return true
      end
    end

end