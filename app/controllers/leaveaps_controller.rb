class LeaveapsController < ApplicationController
    include ApplicationHelper
    
    before_action :logged_in?
    # before_action :user_applicant?, only: [:edit, :update, :destroy]
    # before_action :user_approval?, only: [:approve, :reject]
    # before_action :check_leave_remaining?, only: [:create, :update, :submit]
  
    def index
      respond_to :html, :js
      @leaveaps = Leaveap.where(employee_id: current_user.employee.id)
      @backup_lists = @leaveaps
      if params[:value].present?
        @leaveaps = @leaveaps.where(status_leave_id: params[:value].to_i)
      end
      @leaveap = Leaveap.new
    end

    def project
      respond_to :js
      @leaveaps = Leaveap.where(apv_mgr_1_id: current_user.employee.id).or(Leaveap.where(apv_mgr_2_id: current_user.employee.id))
      @backup_lists = @leaveaps
      if params[:value].present?
        @leaveaps = @leaveaps.where(status_leave_id: params[:value].to_i)
      end
    end

    def new
      respond_to :html, :js
    end
  
    # GET /registers/1/edit
    def edit
      respond_to :html, :js
      @leaveap = Leaveap.find(params[:id])
    end
  
    # POST /leaveaps
    def create
      respond_to :html, :js
      @leaveap = Leaveap.new(leaveap_params)
      @leaveap.days = @leaveap.total_days
      if check_leave_remaining?
        if @leaveap.save
          flash.now[:success] = "Your Leave Application have been Created."
        else
          flash.now[:warning] = @leaveap.errors.full_messages
        end
        @leaveaps = Leaveap.where(employee_id: current_user.employee.id)
      end
    end
  
    # PATCH/PUT /leaveaps/1
    def update
      respond_to :html, :js
      @leaveap = Leaveap.find(params[:id])
      if @leaveap.update(leaveap_params)
        if check_leave_remaining?
          flash.now[:success] = "Your Leave Application have been updated."
          @leaveaps = current_user.employee.leaveaps.order("created_at desc") if current_user.employee
        end
      else
        flash.now[:warning] = "Opps! Something Wrong Please Check with Admin"
      end
    end

    def submit
      respond_to :html, :js
      @leaveap = Leaveap.find(params[:id])
      if check_leave_remaining?
        @leaveap.status_leave_id = 2
        @leaveap.submitted_at = Time.now
        if @leaveap.save
          flash.now[:success] = "Your Leave Application Have Been Submitted."
          UserMailer.submit_leave(@leaveap.id, 1).deliver if @leaveap.apv_mgr_1_id and send_email_notification_submit_leave?
          UserMailer.submit_leave(@leaveap.id, 2).deliver if @leaveap.apv_mgr_2_id and send_email_notification_submit_leave?
        end
      end
    end
  
    # DELETE /leaveaps/1
    # DELETE /leaveaps/1.json
    def destroy
      respond_to :html, :js
      @leaveap = Leaveap.find(params[:id])
      if @leaveap.destroy
        flash.now[:success] = "Your Leave Application have been deleted."
        @leaveaps = current_user.employee.leaveaps.order("created_at desc") if current_user.employee
      else
        flash.now[:warning] = "Opps! Something Wrong Please Check with Admin"
      end
    end

    def approve
      respond_to :html, :js
      @leaveap = Leaveap.find(params[:id])
      @employee = @leaveap.employee
      if check_leave_remaining?
        if params[:value].to_i == 1
          @leaveap.apv_1 = true
        elsif params[:value].to_i == 2
          @leaveap.apv_2 = true
        end
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
          flash.now[:success] = "You have approved leave application, notification has sent to applicant."
          UserMailer.approve_leave(@leaveap.id, params[:value]).deliver if send_email_notification_approve_leave?
        end
      end
    end

    def reject
      respond_to :html, :js
      @leaveap = Leaveap.find(params[:id])
      if params[:value] == 1
        @leaveap.apv_1.to_i = false
      elsif params[:value] == 2
        @leaveap.apv_2.to_i = false
      end
      @leaveap.status_leave_id = 3
      if @leaveap.save
        flash.now[:success] = "You have rejected application, please click on the name to whatsapp the employee."
        UserMailer.reject_leave(@leaveap.id, params[:value]).deliver
      end
    end
  
    private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    
    def user_applicant?
      flash.now[:danger] = "Only the applicant can perform this action."
      Leaveap.find(params[:id]).employee_id == current_user.employee.id
    end

    def user_approval?
      if Leaveap.find(params[:id]).apv_mgr_1_id == current_user.employee.id
        return true
      elsif Leaveap.find(params[:id]).apv_mgr_2_id == current_user.employee.id
        return true
      else
        flash.now[:danger] = "Only the manager can perform this action."
        return false
      end
    end

    def check_leave_remaining?
      @employee = @leaveap.employee
      if @leaveap.leavetype_id == 1 # Annual Leave
        remaining = (@employee.annual_leave_taken + @leaveap.days) - @employee.annual_leave_entitled
        if remaining > 0
          flash.now[:danger] = "Application has exceeded employee's entitled Annual Leave for #{remaining} day(s)."
          return false
        else
          return true
        end
      elsif @leaveap.leavetype_id == 2 # Medical Leave
        remaining = (@employee.medical_leave_taken + @leaveap.days) - @employee.medical_leave_entitled
        if remaining > 0
          flash.now[:danger] =  "Application has exceeded employee's entitled Medical Leave for #{remaining} day(s)."
          return false
        else
          return true
        end
      else
        return true
      end
    end
    
    def leaveap_params
        params.require(:leaveap).permit(:reason, :employee_id, :apv_mgr_1_id, :apv_mgr_2_id, :leavetype_id, :contact_person, :contact_number, :from_date, :to_date, :from_ampm, :to_ampm, :confirm, :days, :attachment_link)
    end
      
  end
  