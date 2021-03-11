class BiddingProfile < ApplicationRecord
  belongs_to :freelancer, class_name: 'User'
  validate :is_user_freelancer?
  validates :freelancer, uniqueness: { message: 'can\'t create more than one profile' }
  validates :category, presence: { message: 'Choose a Category' }
  validates :bio, length: { maximum: 500, message: 'not more than 500 characters' }
  validates :education, length: { maximum: 50, message: 'not more than 50 characters' }
  def is_user_freelancer?
    errors.add(:base, 'Only freelancers are allowed fill this form') unless freelancer.role == 'freelancer'
  end
end
