class PagesController < ApplicationController
  include ApplicationHelper
  def main
    session[:search_type] || search_type('freelancer')
  end

  def search
    if params[:q] && params[:q].reject { |_k, v| v.blank? }.present?
      if search_type? == 'freelancer'
        @freelancers = @q.result(distinct: true).includes(:bidding_profile).order('created_at DESC').page(params[:page]).per(10)

      else
        @projects = @j.result(distinct: true).order('created_at DESC').page(params[:page]).per(10)

      end
    end
  end

  def freelancer_profile
    @freelancer = User.find(params[:id])
  end
end
