class HolidaysController < ApplicationController
    before_action :logged_in?
  
    def index
      respond_to :html, :js
      @holidays = Holiday.all.order("created_at desc")
    end

    def new
      respond_to :html, :js
      @holiday = Holiday.new
    end

    def show
      respond_to :html, :js
    end
  
    # GET /projects/1/edit
    def edit
      respond_to :html, :js
      @holiday = Holiday.find(params[:id])
    end
  
    # POST /projects
    def create
      respond_to :html, :js
      @holiday = Holiday.new(holiday_params)
      if @holiday.save
        flash.now[:success] = "New Holiday have been successfully created."
      else
        flash.now[:warning] = @holiday.errors.full_messages
      end
      @holidays = Holiday.all.order("created_at desc")
    end
  
    # PATCH/PUT /projects/1
    def update
      respond_to :html, :js
      @holiday = Holiday.find(params[:id])
      if @holiday.update(holiday_params)
        flash.now[:success] = "Holiday Information have been successfully updated."
        @holidays = Holiday.all.order("created_at desc")
      else
        flash.now[:warning] = @holiday.errors.full_messages
      end
    end
  
    # DELETE /projects/1
    def destroy
      respond_to :html, :js
      @holiday = Holiday.find(params[:id])
      if @holiday.destroy
        flash.now[:success] = "Holiday have been successfully removed."
        @holidays = Holiday.all.order("created_at desc")
      else
        flash.now[:warning] = "This action couldn't be performed due to error, please check with admin."
      end
    end
  
    private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def holiday_params
        params.require(:holiday).permit(:date, :remarks, :holiday)
    end
      
  end