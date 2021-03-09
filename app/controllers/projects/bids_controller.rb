module Projects
  class BidsController < ApplicationController
    include ApplicationHelper
    before_action :set_bid, only: %i[update accept reject award destroy]
    before_action :authenticate_user!, only: [:history]
    def history
      if user_freelancer?(current_user)
        @bids = Bid.where(freelancer_id: current_user.id).page(params[:page]).per(10)
      else
        authorized_only_to_freelancer
      end
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
        redirect_to root_path
      elsif user_client?(current_user)
        flash[:alert] = 'Become a freelancer to bid on projects'
        redirect_to root_path
      end
    end

    def update
      respond_to do |format|
        format.js
      end
      if @bid.update(bids_params)
        flash[:notice] = 'Successfully updated the bid'
        redirect_to root_path
      end
    end

    def destroy
      @bid.destroy
      flash[:alert] = 'Successfully deleted the proposal'
      redirect_to  bid_history_projects_path
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
