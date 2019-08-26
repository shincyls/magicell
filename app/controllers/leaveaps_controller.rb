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
    end
  
    # POST /leaveaps
    def create
      respond_to :html, :js
      @leaveap = Leaveap.new(leaveap_params)
      @leaveap.save
      @leaveaps = Leaveap.where(id: @leaveap.id)
    end
  
    # PATCH/PUT /registers/1
    def update
    end
  
    # DELETE /registers/1
    # DELETE /registers/1.json
    def destroy
      respond_to :html, :js
    end
  
    private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def leaveap_params
        params.require(:leaveap).permit(:reason, :employee_id, :apv_mgr_1_id, :apv_mgr_2_id, :leavetype_id, :contact_person, :contact_number, :from_date, :to_date, :from_ampm, :to_ampm, :confirm)
    end
      
  end
  