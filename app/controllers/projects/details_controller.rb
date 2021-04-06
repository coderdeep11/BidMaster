include ProjectsHelper
module Projects
  class DetailsController < ApplicationController
    def index
      @project = Project.find(params[:project_id])
      @bids = @project.bids
      @shortlisted = @bids.where('(status =?  OR status =? )', 'awarded', 'accepted')
      redirect_to root_path unless authorize_project(@project)
    end

    def job_post
      @project = Project.find(params[:project_id])
    end

    def review_proposals
      @project = Project.find(params[:project_id])
      @bids = @project.bids
      @shortlisted = @bids.where('(status =?  OR status =? )', 'awarded', 'accepted')
      @rejected = @bids.where(status: 'rejected')
    end

    def all_proposals
      @project = Project.find(params[:project_id])
      @bids = @project.bids.page(params[:page]).per(10)
    end

    def shortlisted
      @project = Project.find(params[:project_id])
      @bids = @project.bids
      @shortlisted = @bids.where('(status =?  OR status =? )', 'awarded', 'accepted').page(params[:page]).per(10)
    end

    def rejected
      @project = Project.find(params[:project_id])
      @bids = @project.bids
      @rejected = @bids.where(status: 'rejected').page(params[:page]).per(10)
    end
  end
end
