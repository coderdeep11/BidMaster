class ProfilesController < ApplicationController
  include ProfilesHelper
  include ApplicationHelper
  before_action :set_client, only: [:view_client]
  before_action :set_user, only: %i[about experience details]
  before_action :set_freelancer, only: [:view_freelancer]
  before_action :authenticate_user!, only: [:view_client]

  def view_freelancer
    if @freelancer.nil?
      @freelancer = current_user
      flash[:alert] = 'no-freelancer-exists'
      redirect_to user_freelancer?(current_user) ? freelancer_path(current_user) : client_path(current_user)

    end
  end

  def view_client
    if @client.nil?
      @client = current_user
      redirect_to user_freelancer?(current_user) ? freelancer_path(current_user) : client_path(current_user)

      flash[:alert] = 'no-client-exists'

    else
      unless authorize_client(@client)
        flash[:alert] = 'not accessible'
        redirect_to user_freelancer?(current_user) ? freelancer_path(current_user) : client_path(current_user)
      end
    end
  end

  def about; end

  def experience; end

  def details; end

  private

  def set_freelancer
    @freelancer = User.find_by(id: params[:id], role: 'freelancer')
  end

  def set_client
    @client = User.find_by(id: params[:id], role: 'client')
  end

  def set_user
    @user = User.find(params[:id])
  end
end
