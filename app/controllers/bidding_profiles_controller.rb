class BiddingProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_bidding_profile, only: %i[edit update show]
  include BiddingProfilesHelper
  def index
    if user_freelancer?(current_user)
      @projects = Project.all.order('created_at desc').page(params[:page]).per(5)
    else
      flash[:alert] = 'not authorized'
      redirect_to root_path
    end
  end

  def new
    authorized_only_to_freelancers unless user_freelancer?(current_user)
    if bidding_profile_exist?
      redirect_to root_path
    else
      @bidding_profile = BiddingProfile.new
    end
  end

  def create
    @bidding_profile = BiddingProfile.new(bidding_profile_params)
    @bidding_profile.freelancer = current_user
    if @bidding_profile.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def show
    redirect_to freelancer_path(@bidding_profile.freelancer)
  end

  def edit
    unless authorize_bidding_profile(@bidding_profile)
      flash[:alert] = 'access denied'
      redirect_to root_path
    end
  end

  def update
    if @bidding_profile.update(bidding_profile_params)
      flash[:notice] = 'Successfully,updated profile.'
      redirect_to freelancer_path(@bidding_profile.freelancer)
    else
      render 'edit'
    end
  end

  private

  def set_bidding_profile
    @bidding_profile = BiddingProfile.find(params[:id])
  end

  def bidding_profile_params
    params.require(:bidding_profile).permit(:category, :subcategory, :experience, :education, :bio, :freelancer_id)
  end
end
