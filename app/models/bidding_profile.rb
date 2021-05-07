class BiddingProfile < ApplicationRecord
  belongs_to :freelancer, class_name: 'User'

  validates :category, presence: { message: 'Choose a Category' }
  validates :freelancer_id, presence: { message: 'must select a Freelancer' }, uniqueness: { message: 'freelancer already have a bidding profile' }

  scope :exist?, ->(current_user) { where(freelancer: current_user) }
  # Ex:- scope :active, -> {where(:active => true)}
end
