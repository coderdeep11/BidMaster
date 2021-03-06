class FreelancerInfosController < ApplicationController
  before_action :authenticate_user!

  def index
    if user_freelancer?(current_user)
      @projects = Project.all.order('created_at desc').page(params[:page]).per(5)
    else
      flash[:alert] = 'not authorized'
      redirect_to root_path
    end
  end

  def create
    @freelancer_info = FreelancerInfo.new(freelancer_params)
    @freelancer_info.freelancer = current_user
    redirect_to root_path if @freelancer_info.save
  end

  def edit; end

  def update; end

  private

  def freelancer_params
    params.permit(:category, :subcategory, :experience, :education, :hourly_rate, :bio, :freelancer_id)
  end
end
