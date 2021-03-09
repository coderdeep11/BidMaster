class FreelancerInfosController < ApplicationController
  before_action :authenticate_user!
  before_action :set_freelancer_info, only: %i[edit update]
  include FreelancerInfosHelper
  def index
    if user_freelancer?(current_user)
      @projects = Project.all.order('created_at desc').page(params[:page]).per(5)
    else
      flash[:alert] = 'not authorized'
      redirect_to root_path
    end
  end

  def new
    if freelancer_already_registered?
      flash[:alert] = 'You have already done the registration'
      redirect_to root_path
    else
      @freelancer_info = FreelancerInfo.new
    end
  end

  def create
    @freelancer_info = FreelancerInfo.new(freelancer_params)
    @freelancer_info.freelancer = current_user
    if @freelancer_info.save
      redirect_to root_path
    else
      render 'new'
    end
  end

  def edit
    unless authorize_freelancer_info(@freelancer_info)
      flash[:alert] = 'access denied'
      redirect_to root_path
    end
  end

  def update
    if @freelancer_info.update(freelancer_params)
      flash[:notice] = 'Successfully,updated profile.'
      redirect_to freelancer_path(@freelancer_info.freelancer)
    else
      render 'edit'
    end
  end

  private

  def set_freelancer_info
    @freelancer_info = FreelancerInfo.find(params[:id])
  end

  def freelancer_params
    params.require(:freelancer_info).permit(:category, :subcategory, :experience, :education, :bio, :freelancer_id)
  end
end
