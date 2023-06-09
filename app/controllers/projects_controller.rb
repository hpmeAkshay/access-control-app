class ProjectsController < ApplicationController
    include SessionsHelper

    before_action :authorize_manager_or_admin, only: [:edit, :update, :index, :new, :create]
    before_action :authorize_creator, only: [:destroy ]
     

    def index
        @projects=Project.all
    end

    def show
        @project=Project.find(params[:id])
    end

    def new
        @project=Project.new
    end
    
    def create
        @project=Project.new(project_params)
        if @project.save
            redirect_to projects_path, notice: "Project is successfully created"
        else
            render :new
        end
    end

    def edit
        @project=Project.find(params[:id])
    end

    def update
        @project = Project.find(params[:id])
        if @project.update(project_params)
            redirect_to projects_url, notice: "Project is successfully updated"
        else
            render :edit
        end
    end

    def destroy
        @project=Project.find(params[:id])
        @project.destroy
        redirect_to projects_url, notice: "Project was successfully destroyed"
    end

    private

    def project_params
        params.require(:project).permit(:name, :description, :user_id)
    end

    def authorize_admin
        unless current_user.admin?
          redirect_to root_url, notice: "Access denied"
        end
    end

    def authorize_manager_or_admin
        unless current_user.manager? || current_user.admin?
            redirect_to root_url, notice: "Access denied"
        end
    end

    def authorize_creator
        @project=Project.find(params[:id])
        unless current_user.id==@project.user_id && current_user.manager? || current_user.admin?
            redirect_to root_url, notice: "Access denied"
        end
    end
    
end
