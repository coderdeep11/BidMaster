class ProjectsController < ApplicationController
  def index
    @project = Project.new
    @projects=Project.all;
    session[:project_param] ||= {}
  end

  def create
    @project = Project.new(project_params)

    session[:project_param].deep_merge!(params[:project].to_unsafe_hash) if params[:project]
    @project.assign_attributes(session[:project_param])
    @project.current_step = session[:step_id]
    @project.client_id = current_user.id
    if @project.valid?
      if params[:back_btn]
        @project.prev_step
      elsif @project.last_step
        @project.save
      else
        @project.next_step
      end
      session[:step_id] = @project.current_step
    end

    if @project.new_record?
      respond_to do |format|
        format.html { render 'index' }
        format.js
      end

    else

      session[:project_param] = session[:step_id] = nil
      sleep 2
      redirect_to projects_path
    end
  end

  def show
    @project = Project.find(params[:id])

    @bid = Bid.new
    @bids = @project.bids
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
    params.permit(:title, :category, :subcategory, :description, :experience, :min_budget, :max_budget, :client_id)
  end
end
