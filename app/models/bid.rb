class Bid < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer, class_name: 'User'
  has_one :notification
  validates :value, presence: { message: 'must have a value' }
  validates :freelancer_id, uniqueness: { scope: :project_id, message: 'you already placed a bid' }
  after_create :send_notifications_to_client
  before_update :send_notifications_to_freelancer, if: :approved_changed?

  def send_notifications_to_client
    Notification.create!(user_id: project.client.id, bid_id: id)
  end

  def send_notifications_to_freelancer
    Notification.create!(user_id: freelancer.id, bid_id: id)
  end
end
