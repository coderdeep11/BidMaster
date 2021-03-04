class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  def index
    if user_freelancer?(current_user)
      flash[:alert] = 'not authorized!'
      redirect_to root_path
    else
      @projects = Project.where(client: current_user)
    end
  end

  def new
    @project = Project.new
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
    @project = Project.find(params[:id])
    @bid_by_current_user = Bid.find_by(freelancer: current_user, project: @project)
    @bid = @bid_by_current_user.nil? ? Bid.new : @bid_by_current_user
    @bids = @project.bids
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @project = Project.find(params[:id])
  end

  def update
    @project = Project.find(params[:id])
    @project.update_attributes(project_params)
    redirect_to projects_path
  end

  private

  def project_params
    params.require(:project).permit(:title, :category, :subcategory, :description, :experience, :min_budget, :max_budget, :client_id)
  end
end
