module Admin
  class BidsController < ApplicationController
    before_action :authorized_only_to_admin!
    before_action :set_bid, only: %i[edit update show destroy]
    def index
      @bids = Bid.all.order('created_at DESC').page(params[:page]).per(10)
    end

    def new
      @bid = Bid.new
    end

    def create
      @bid = Bid.new(bid_params)
      if @bid.save

        redirect_to admin_bids_path
      else

        render 'admin/bids/new'
      end
    end

    def edit; end

    def update
      if @bid.update(bid_params)
        flash[:notice] = 'Successfully,updated bid.'
        redirect_to admin_bids_path
      else
        render 'admin/bids/edit'
      end
    end

    def show; end

    def destroy
      @bid.destroy
      flash[:notice] = 'Successfully,deleted the bid'
      redirect_to admin_bids_path
    end

    private

    def set_bid
      @bid = Bid.find(params[:id])
      @project = @bid.project
    end

    def bid_params
      params.require(:bid).permit(:value, :proposal, :freelancer_id, :project_id, :status, documents: [])
    end
  end
end
