class DropdownsController < ApplicationController
  def user_profile
    @user = current_user
  end
end
