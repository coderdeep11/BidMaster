class BidsController < ApplicationController
  def index
    @project = Project.find(params[:project_id])
    @bids = @project.bids
  end

  def create
    @project = Project.find(params[:project_id])
    @bid = @project.bids.new(bids_params)
    @bid.freelancer_id = current_user.id
    if @bid.save
      respond_to do |format|
        format.js
      end

    end
  end

  private

  def bids_params
    params.require(:bid).permit(:value, :proposal, :freelancer_id, :project_id)
  end
end
