class NotificationsController < ApplicationController
  def index
    @notifications = Notification.where(user_id: current_user.id)
  end
end
