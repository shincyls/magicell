class LeaveapsController < ApplicationController
    include ApplicationHelper
    
    before_action :logged_in?
    before_action :user_applicant?, only: [:edit, :update, :destroy]
    before_action :user_approval?, only: [:approve, :reject]
  
    def index
      respond_to :html, :js
      @leaveaps = Leaveap.where(employee_id: current_user.employee.id)
      @backup_lists = @leaveaps
      if params[:value].to_i > 1
        @leaveaps = Leaveap.where(employee_id: current_user.employee.id, status_leave_id: params[:value])
      end
      @leaveap = Leaveap.new
    end

    def project
      respond_to :js
      @leap = Leaveap.where(apv_mgr_1_id: current_user.employee.id).or(Leaveap.where(apv_mgr_2_id: current_user.employee.id))
      # @leap = (Leaveap.where(apv_mgr_1_id: current_user.employee.id, status_leave_id: [2,3,4]) + Leaveap.where(apv_mgr_2_id: current_user.employee.id, status_leave_id: [2,3,4])).uniq
      @backup_lists = @leap
      if params[:value].to_i > 1
        @leap = Leaveap.where(apv_mgr_1_id: current_user.employee.id).or(Leaveap.where(apv_mgr_2_id: current_user.employee.id))
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
      if @leaveap.save
        flash.now[:success] = "Your Leave Application have been submitted."
      else
        flash.now[:warning] = @leaveap.errors.full_messages
      end
      @leaveaps = Leaveap.where(employee_id: current_user.employee.id)
    end
  
    # PATCH/PUT /leaveaps/1
    def update
      respond_to :html, :js
      @leaveap = Leaveap.find(params[:id])
      if @leaveap.update(leaveap_params)
        flash.now[:success] = "Your Leave Application have been updated."
        @leaveaps = current_user.employee.leaveaps.order("created_at desc") if current_user.employee
      else
        flash.now[:warning] = "Opps! Something Wrong Please Check with Admin"
      end
    end

    def submit
      respond_to :html, :js
      @leaveap = Leaveap.find(params[:id])
      @leaveap.status_leave_id = 2
      @leaveap.submitted_at = Time.now
      if @leaveap.save
        flash.now[:success] = "Your Leave Application Have Been Submitted."
        UserMailer.submit_leave(@la.id, 1).deliver if @la.apv_mgr_1_id
        UserMailer.submit_leave(@la.id, 2).deliver if @la.apv_mgr_2_id
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
        UserMailer.approve_leave(@leaveap.id, params[:value]).deliver
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
        flash.now[:success] = "You have rejected application, notification has sent to applicant."
        UserMailer.reject_leave(@leaveap.id, params[:value]).deliver
      end
    end
  
    private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    
    def user_applicant?
      Leaveap.find(params[:id]).employee_id == current_user.employee.id
    end

    def user_approval?
      if Leaveap.find(params[:id]).apv_mgr_1_id == current_user.employee.id
        return true
      elsif Leaveap.find(params[:id]).apv_mgr_2_id == current_user.employee.id
        return true
      else
        return false
      end
    end
    
    def leaveap_params
        params.require(:leaveap).permit(:reason, :employee_id, :apv_mgr_1_id, :apv_mgr_2_id, :leavetype_id, :contact_person, :contact_number, :from_date, :to_date, :from_ampm, :to_ampm, :confirm, :attachment_link)
    end
      
  end
  