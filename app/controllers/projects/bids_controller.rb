module Projects
  class BidsController < ApplicationController
    before_action :set_bid, only: %i[update accept reject award]
    def history
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
      @bid.update_attributes(bids_params)
      redirect_to notifications_path
    end

    def accept
      @bid.accept! unless @bid.rejected? || @bid.accepted?
      redirect_to(request.referrer || root_path)
    end

    def reject
      @bid.reject! unless @bid.rejected?
      redirect_to(request.referrer || root_path)
    end

    def award
      @bid.award!
      redirect_to(request.referrer || root_path)
    end

    private

    def set_bid
      @project = Project.find(params[:project_id])
      @bid = @project.bids.find(params[:id])
    end

    def bids_params
      params.require(:bid).permit(:value, :proposal, :freelancer_id, :project_id, :aasm_state)
    end
  end
end
