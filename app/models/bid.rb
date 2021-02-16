class Bid < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer, class_name: 'User'
  has_one :notification
  validates :value, presence: { message: 'must have a value' }
  validates :freelancer_id, uniqueness: { scope: :project_id, message: 'you already placed a bid' }
  after_create :send_notifications_to_client

  include AASM

  aasm do
    state :unapproved, initial: true
    state :accepted, :rejected, :awarded

    event :accept do
      transitions from: :unapproved, to: :accepted, after: :send_notifications_to_freelancer
    end

    event :award do
      transitions from: :accepted, to: :awarded
    end
    event :reject do
      transitions from: %i[unapproved], to: :rejected, after: :send_notifications_to_freelancer
      transitions from: :accepted, to: :rejected
    end
  end

  def send_notifications_to_client
    Notification.create!(user_id: project.client.id, bid_id: id)
  end

  def send_notifications_to_freelancer
    Notification.create!(user_id: freelancer.id, bid_id: id)
  end
end
