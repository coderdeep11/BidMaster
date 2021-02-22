class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = Notification.where(user_id: current_user.id).joins(:bid).order('bids.updated_at DESC')
  end
end
