class AnnouncementsController < ApplicationController
    before_action :logged_in?
  
    def index
      respond_to :html, :js
      @announcements = Announcement.all.order("created_at desc")
    end

    def new
      respond_to :html, :js
      @announcement = Announcement.new
    end

    def show
      respond_to :html, :js
    end
  
    # GET /Announcements/1/edit
    def edit
      respond_to :html, :js
      @announcement = Announcement.find(params[:id])
    end
  
    # POST /Announcements
    def create
      respond_to :html, :js
      @announcement = Announcement.new(announcement_params)
      if @announcement.save
        flash.now[:success] = "New Announcement have been successfully created."
      else
        flash.now[:warning] = @announcement.errors.full_messages
      end
      @announcements = Announcement.all.order("created_at desc")
    end
  
    # PATCH/PUT /Announcements/1
    def update
      respond_to :html, :js
      @announcement = Announcement.find(params[:id])
      if @announcement.update(announcement_params)
        flash.now[:success] = "Announcement have been successfully updated."
        @announcements = Announcement.all.order("created_at desc")
      else
        flash.now[:warning] = @Announcement.errors.full_messages
      end
    end
  
    # DELETE /Announcements/1
    def destroy
      respond_to :html, :js
      @announcement = Announcement.find(params[:id])
      if @announcement.destroy
        flash.now[:success] = "Announcement have been successfully removed."
        @announcements = Announcement.all.order("created_at desc")
      else
        flash.now[:warning] = "This action couldn't be performed due to error, please check with admin."
      end
    end

    def display
      respond_to :html, :js
      @annc = Announcement.find(params[:id])
      @annc.show = !@annc.show
      @annc.save
    end
  
    private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def announcement_params
        params.require(:announcement).permit(:announcement, :remarks, :start_date, :end_date)
    end
      
  end