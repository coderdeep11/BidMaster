class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_project, only: %i[show edit update destroy more_info]
  include ProjectsHelper
  def index
    if user_client?(current_user)
      @projects = Project.my_projects(current_user).order('created_at desc').page(params[:page]).per(10)
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

  def edit
    unless authorize_project(@project)
      flash[:alert] = 'access denied'
      redirect_to root_path
    end
  end

  def update
    if @project.update(project_params)
      flash[:notice] = 'Successfully,edited  project'
      redirect_to project_details_path(@project)
    else
      render 'edit'
    end
  end

  def destroy
    @project.destroy
    flash[:notice] = 'Successfully,deleted the project'
    redirect_to root_path
  end

  def more_info; end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :category, :subcategory, :description, :experience, :min_budget, :max_budget, :client_id)
  end
end
