class Notification < ApplicationRecord
  belongs_to :user, inverse_of: :notifications
  belongs_to :bid

  scope :my_notifications, ->(current_user) { where(user_id: current_user.id).joins(:bid) }
  scope :unread_notifications, ->(current_user) { where('user_id = ? AND read = ?', current_user.id, false) }
  scope :total_unread_notifications_count, ->(current_user) { where(user: current_user, read: false).count }

  validates_uniqueness_of :user_id, scope: :bid_id
end
