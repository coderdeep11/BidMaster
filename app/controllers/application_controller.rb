class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_global_search_variable
  require 'action_view'
  include ActionView::Helpers::DateHelper
  include ApplicationHelper
  def set_global_search_variable
    @q = User.where(role: 'freelancer').ransack(params[:q])
    @j = Project.ransack(params[:q])
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name role profile_image])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name role profile_image])
  end
end
