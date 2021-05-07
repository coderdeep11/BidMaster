class PagesController < ApplicationController
  include ApplicationHelper
  def main
    session[:search_type] || search_type('freelancer')
  end

  def search
    if search_type? == 'freelancer'
      @freelancers = @q.result(distinct: true).includes(:bidding_profile).order('created_at DESC').page(params[:page]).per(10)

    elsif search_type? == 'project'
      @projects = @j.result(distinct: true).order('created_at DESC').page(params[:page]).per(10)
    else
      @users = @k.result(distinct: true).order('created_at DESC').page(params[:page]).per(10)
    end
  end

  def freelancer_profile
    @freelancer = User.find(params[:id])
  end
end
