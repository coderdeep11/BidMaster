class ApplicationController < ActionController::Base
  before_action :set_global_search_variable
  helper_method :logged_in?, :current_user

  require 'action_view'
  include ActionView::Helpers::DateHelper
  include ApplicationHelper
  def set_global_search_variable
    @q = User.where(role: 'freelancer').ransack(params[:q])
    @j = Project.ransack(params[:q])
  end

  def current_user
    @user = User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def authenticate_user!
    redirect_to login_path unless logged_in?
  end
end
