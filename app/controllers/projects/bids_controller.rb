module Projects
  class BidsController < ApplicationController
    include ApplicationHelper
    before_action :set_bid, only: %i[update accept reject award]
    def history
      @bids = Bid.where(freelancer_id: current_user.id)
    end

    def create
      @project = Project.find(params[:project_id])
      @bid = @project.bids.new(bids_params)
      respond_to do |format|
        format.js
      end
      @bid.freelancer = current_user if current_user && user_freelancer?(current_user)

      if @bid.save
        flash[:notice] = 'Successfully placed a bid'
        redirect_to root_path(@project)
      elsif !user_freelancer?(current_user)
        flash[:alert] = 'Become a freelancer to bid on projects'
        redirect_to root_path(@project)
      end
    end

    def update
      @bid.update_attributes(bids_params)
      redirect_to notifications_path
    end

    def accept
      @bid.accept! unless @bid.rejected? || @bid.accepted?
    end

    def reject
      @bid.reject! unless @bid.rejected?
    end

    def award
      @bid.award! unless @bid.awarded?
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
