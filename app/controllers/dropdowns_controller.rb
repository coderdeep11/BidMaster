class DropdownsController < ApplicationController
  include ApplicationHelper
  def user_profile
    @user = current_user
  end

  def search_choice; end

  def freelancer
    search_type('freelancer')
  end

  def project
    search_type('project')
  end

  def client_and_freelancer
    search_type('all')
  end
end
