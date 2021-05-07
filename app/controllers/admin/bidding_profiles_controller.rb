module Admin
  class BiddingProfilesController < ApplicationController
    before_action :authorized_only_to_admin!
    before_action :set_bidding_profile, only: %i[edit update show destroy]
    def index
      @bidding_profiles = BiddingProfile.all.order('created_at DESC').page(params[:page]).per(10)
    end

    def new
      @bidding_profile = BiddingProfile.new
    end

    def create
      @bidding_profile = BiddingProfile.new(bidding_profile_params)
      if @bidding_profile.save

        redirect_to admin_bidding_profiles_path
      else

        render 'admin/bidding_profiles/new'
      end
    end

    def edit; end

    def update
      if @bidding_profile.update(bidding_profile_params)
        flash[:notice] = 'Successfully,updated bidding_profile.'
        redirect_to admin_bidding_profiles_path
      else
        render 'admin/bidding_profiles/edit'
      end
    end

    def show; end

    def destroy
      @bidding_profile.destroy
      flash[:notice] = 'Successfully,deleted the bidding_profile'
      redirect_to admin_bidding_profiles_path
    end

    private

    def set_bidding_profile
      @bidding_profile = BiddingProfile.find(params[:id])
    end

    def bidding_profile_params
      params.require(:bidding_profile).permit(:category,:bio, :subcategory, :experience, :education, :freelancer_id)
    end
  end
end
