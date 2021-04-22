include ProjectsHelper
module Projects
  class DetailsController < ApplicationController
    before_action :set_project, only: %i[index job_post review_proposals shortlisted rejected]

    def index
      @shortlisted = @bids.shortlisted_bids
      redirect_to root_path unless authorize_project(@project)
    end

    def job_post; end

    def review_proposals
      @shortlisted = @bids.shortlisted_bids
      @rejected = @bids.rejected_bids
    end

    def all_proposals
      @project = Project.find(params[:project_id])
      @bids = @project.bids.page(params[:page]).per(10)
    end

    def shortlisted
      @shortlisted = @bids.shortlisted_bids.page(params[:page]).per(10)
    end

    def rejected
      @rejected = @bids.rejected_bids.page(params[:page]).per(10)
    end

    private

    def set_project
      @project = Project.find(params[:project_id])
      @bids = @project.bids
    end
  end
end
