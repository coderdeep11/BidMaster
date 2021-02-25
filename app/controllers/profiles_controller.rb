class ProfilesController < ApplicationController
  def view
    @user = current_user
  end
  def about
    @user = current_user
  end

  def experience
    @user = current_user
  end

  def details
    @user = current_user
  end
end
