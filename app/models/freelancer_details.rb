class FreelancerInfo < ApplicationRecord
  belongs_to :freelancer_details, class_name: 'User'
  validate :is_user_freelancer_details?
  validates :freelancer_details, uniqueness: { message: 'freelancer_details can\'t have more than one profile' }
  validates :category, presence: { message: 'Choose a Category' }
  validates :bio, length: { maximum: 500, message: 'not more than 500 characters' }
  validates :education, length: { maximum: 50, message: 'not more than 50 characters' }
  def is_user_freelancer_details?
    errors.add(:base, 'Only freelancer_detailss are to fill this form') unless freelancer_details.role == 'freelancer_details'
  end
end
