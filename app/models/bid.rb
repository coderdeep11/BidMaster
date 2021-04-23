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
  # scopes
  scope :shortlisted_bids, -> { where('(status =?  OR status =? )', 'awarded', 'accepted') }
  scope :rejected_bids, -> { where(status: 'rejected') }
  scope :my_bids, ->(current_user) { where(freelancer_id: current_user.id) }
  scope :awarded_bids, ->(user) { where('(status =? and freelancer_id =?)', 'awarded', user.id).count }
  scope :average_bid, ->(user) { where(freelancer_id: user.id).average(:value).to_i || 0 }
  scope :max_bid_value, ->(user) { where(freelancer_id: user.id).maximum('value') || 0 }
  scope :min_bid_value, ->(user) { where(freelancer_id: user.id).minimum('value') || 0 }
  scope :max_bid_on_project, ->(project) { where(project: project).maximum('value') || 0 }
  scope :avg_bid_on_project, ->(project) { where(project: project).average('value').to_i || 0 }
  scope :exist, ->(user) { where(freelancer: user).count  }

  def proposal_words_within_limit?
    unless proposal.nil?
      errors.add(:proposal, 'proposal should contain atleast 10 words') unless proposal.split(' ').length > 10
    end
  end

  def is_user_freelancer?
    errors.add(:base, 'Only freelancers are allowed to bid') unless freelancer&.role == 'freelancer'
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
