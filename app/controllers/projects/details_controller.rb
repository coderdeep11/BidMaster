include ProjectsHelper
module Projects
  class DetailsController < ApplicationController
    def index
      @project = Project.find(params[:project_id])
      @bids = @project.bids
      @shortlisted = @bids.where('(aasm_state =?  OR aasm_state =? )', 'awarded', 'accepted')
      redirect_to notifications_path unless authorize_project(@project)
    end

    def job_post
      @project = Project.find(params[:project_id])
    end

    def review_proposals
      @project = Project.find(params[:project_id])
      @bids = @project.bids
      @shortlisted = @bids.where('(aasm_state =?  OR aasm_state =? )', 'awarded', 'accepted')
      @rejected = @bids.where(aasm_state: 'rejected')
    end

    def all_proposals
      @project = Project.find(params[:project_id])
      @bids = @project.bids.page(params[:page]).per(10)
    end

    def shortlisted
      @project = Project.find(params[:project_id])
      @bids = @project.bids
      @shortlisted = @bids.where('(aasm_state =?  OR aasm_state =? )', 'awarded', 'accepted').page(params[:page]).per(3)
    end

    def rejected
      @project = Project.find(params[:project_id])
      @bids = @project.bids
      @rejected = @bids.where(aasm_state: 'rejected').page(params[:page]).per(10)
    end
  end
end
