class NotificationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @notifications = Notification.where(user_id: current_user.id)
    @conversation = Conversation.where('sender_id =? OR recipient_id =?', current_user.id, current_user.id).first
  end
end
