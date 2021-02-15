class BidsController < ApplicationController
  def bid_history
    @bids = Bid.where(freelancer_id: current_user.id)
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

  def update
    @project = Project.find(params[:project_id])
    @bid = @project.bids.find(params[:id])

    @bid.update_attributes(bids_params)
    redirect_to notifications_path
  end

  private

  def bids_params
    params.require(:bid).permit(:value, :proposal, :freelancer_id, :project_id, :approved)
  end
end
