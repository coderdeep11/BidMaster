class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_project, only: %i[show edit update destroy]
  def index
    if user_client?(current_user)
      @projects = Project.where(client: current_user).order('created_at desc').page(params[:page]).per(10)
    else
      authorized_only_to_clients
    end
  end

  def new
    if user_client?(current_user)
      @project = Project.new
    else
      authorized_only_to_clients
    end
  end

  def create
    @project = Project.new(project_params)
    @project.client_id = current_user.id
    if @project.save
      flash[:notice] = 'Successfully,posted a project'
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    @bid_by_current_user = Bid.find_by(freelancer: current_user, project: @project)
    @bid = @bid_by_current_user.nil? ? Bid.new : @bid_by_current_user

    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit; end

  def update
    @project.update_attributes(project_params)
    redirect_to projects_path
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :category, :subcategory, :description, :experience, :min_budget, :max_budget, :client_id)
  end
end
