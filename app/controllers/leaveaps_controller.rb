class LeaveapsController < ApplicationController
    include ApplicationHelper
    
    before_action :logged_in?
  
    def index
      respond_to :html, :js
      @leaveaps = current_user.employee.leaveaps.order("created_at desc") if current_user.employee
      @leaveap = Leaveap.new
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
        @leaveaps = Leaveap.where(id: @leaveap.id)
        flash.now[:success] = "Your Leave Application have been submitted."
      else
        flash.now[:warning] = "Opps! Something Wrong Please Check with Admin"
      end
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
      @la = Leaveap.find(params[:id])
      @la.submitted = true
      if @la.save
        flash.now[:success] = "Your Leave Application Have Been Submitted."
      end
      @leaveaps = current_user.employee.leaveaps.order("created_at desc") if current_user.employee
      @leaveap = Leaveap.new
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

    def leave_approval1
      respond_to :html, :js
      @la = Leaveap.find(params[:id])
      @la.apv_1 = !@la.apv_1
      @la.save
    end

    def leave_approval2
      respond_to :html, :js
      @la = Leaveap.find(params[:id])
      @la.apv_2 = !@la.apv_2
      @la.save
    end
  
    private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def leaveap_params
        params.require(:leaveap).permit(:reason, :employee_id, :apv_mgr_1_id, :apv_mgr_2_id, :leavetype_id, :contact_person, :contact_number, :from_date, :to_date, :from_ampm, :to_ampm, :confirm)
    end
      
  end
  