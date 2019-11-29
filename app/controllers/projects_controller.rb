class ProjectsController < ApplicationController
    before_action :logged_in?
  
    def index
      respond_to :html, :js
      if params[:value].present?
        @projects = Project.where(project_status: params[:value].to_i).order("created_at desc")
      else
        @projects = Project.all.order("created_at desc")
      end
    end

    def new
      respond_to :html, :js
      @project = Project.new
    end

    def show
      respond_to :html, :js
    end
  
    # GET /projects/1/edit
    def edit
      respond_to :html, :js
      @project = Project.find(params[:id])
    end
  
    # POST /projects
    def create
      respond_to :html, :js
      @project = Project.new(project_params)
      if @project.save
        flash.now[:success] = "New Project have been successfully created."
      else
        flash.now[:warning] = @project.errors.full_messages
      end
      @projects = Project.all.order("created_at desc")
    end
  
    # PATCH/PUT /projects/1
    def update
      respond_to :html, :js
      @project = Project.find(params[:id])
      if @project.update(project_params)
        flash.now[:success] = "Project information have been successfully updated."
      else
        flash.now[:warning] = @project.errors.full_messages
      end
    end
  
    # DELETE /projects/1
    def destroy
      respond_to :html, :js
      @project = Project.find(params[:id])
      if @project.destroy
        flash.now[:success] = "Project have been successfully removed."
        @projects = Project.all.order("created_at desc")
      else
        flash.now[:warning] = "This action couldn't be performed due to error, please check with admin."
      end
    end
  
    private
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
        params.require(:project).permit(:name, :description, :vendor, :operator, :department_id, :manager_id, :manager_alt_id, :project_status)
    end
      
  end