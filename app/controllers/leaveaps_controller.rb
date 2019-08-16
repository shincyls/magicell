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
  
    # POST /registers
    def create
    end
  
    # PATCH/PUT /registers/1
    def update
    end
  
    # DELETE /registers/1
    # DELETE /registers/1.json
    def destroy
    end
  
    private
  
    
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def leaveap_params
        params.require(:leaveap).permit(:reason, :leave_type, :contact_person, :contact_number, :from_date, :to_date, :confirm, :approved_1, :approved_2, :approved_3, :reject_reason_1, :reject_reason_2, :reject_reason_3)
    end
      
  end
  