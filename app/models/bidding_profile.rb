class BiddingProfile < ApplicationRecord
  belongs_to :freelancer, class_name: 'User'
  validate :is_user_freelancer?

  validates :category, presence: { message: 'Choose a Category' }
  validates :bio, length: { maximum: 500, message: 'not more than 500 characters' }
  validates :education, length: { maximum: 50, message: 'not more than 50 characters' }
  validates :freelancer_id, presence: { message: 'must select a Freelancer' }, uniqueness: { message: 'freelancer already have a bidding profile' }

  def is_user_freelancer?
    errors.add(:base, 'Only freelancers are allowed fill this form') unless freelancer.try(:role) == 'freelancer'
  end
end
