class FreelancerInfosController < ApplicationController
  before_action :authenticate_user!

  def index
    @projects = Project.all
  end

  def create
    @freelancer_info = FreelancerInfo.new(freelancer_params)
    @freelancer_info.freelancer = current_user
    redirect_to root_path if @freelancer_info.save
  end

  def edit; end

  def update; end

  def show
    @user=User.find(params[:id])
  end

  def freelancer_params
    params.permit(:category, :subcategory, :experience, :education, :hourly_rate, :bio, :freelancer_id)
  end
end
