class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = Notification.my_notifications(current_user).order('bids.updated_at DESC').page(params[:page]).per(10)
    Notification.unread_notifications(current_user).update_all(read: true)
    respond_to do |format|
      format.js {}
    end
  end
end
