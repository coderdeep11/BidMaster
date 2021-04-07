module Admin
  class ProjectsController < ApplicationController
    before_action :authorized_only_to_admin!
    before_action :set_project, only: %i[edit update show destroy]
    def index
      @projects = Project.all.order('created_at DESC')
    end

    def new
      @project = Project.new
    end

    def create
      @project = Project.new(project_params)

      if @project.save

        redirect_to admin_projects_path
      else

        render 'admin/projects/new'
      end
    end

    def edit; end

    def update
      if @project.update(project_params)
        flash[:notice] = 'Successfully,updated Project.'
        redirect_to admin_projects_path
      else
        render 'admin/projects/edit'
      end
    end

    def show; end

    def destroy
      @project.destroy
      flash[:notice] = 'Successfully,deleted the project'
      redirect_to admin_projects_path
    end

    private

    def set_project
      @project = Project.find(params[:id])
    end

    def project_params
      params.require(:project).permit(:title, :category, :subcategory, :experience, :client_id, :description)
    end
  end
end
