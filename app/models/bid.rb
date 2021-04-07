class Bid < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer, class_name: 'User', inverse_of: :bids
  has_many :notifications, dependent: :destroy
  validates :value, presence: { message: "*can't be blank! " }, numericality: { less_than_or_equal_to: 500, greater_than_or_equal_to: 30, only_integer: true, message: '  must be between $30 and $500' }
  validates :proposal, length: { in: 50..400, message: '*should be within 50-400 words' }
  validate :proposal_words_within_limit?
  validates :freelancer_id, presence: { message: 'must select a freelancer' }, uniqueness: { scope: :project_id, message: 'freelancer already placed a bid on this project' }
  validates :project_id, presence: { message: 'must select a project' }

  validate :is_user_freelancer?
  after_create :send_notifications_to_client

  before_update :send_notifications_to_freelancer
  enum status: {
    unapproved: 'unapproved',
    accepted: 'accepted',
    rejected: 'rejected',
    awarded: 'awarded'
  }

  def proposal_words_within_limit?
    unless proposal.nil?
      errors.add(:proposal, 'proposal should contain atleast 10 words') unless proposal.split(' ').length > 10
    end
  end

  def is_user_freelancer?
    errors.add(:base, 'Only freelancers are allowed to bid') unless freelancer.try(:role) == 'freelancer'
  end

  def send_notifications_to_client
    Notification.create!(user_id: project.client.id, bid_id: id)
  end

  def send_notifications_to_freelancer
    unless changed_attributes[:status].nil?
      Notification.create!(user_id: freelancer.id, bid_id: id) if accepted? || rejected?
    end
  end
end
