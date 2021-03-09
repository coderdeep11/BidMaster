class NotificationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @notifications = Notification.where(user_id: current_user.id).joins(:bid).order('bids.updated_at DESC').page(params[:page]).per(10)
    Notification.where('user_id = ? AND read = ?', current_user.id, false).update_all(read: true)
  end
end
