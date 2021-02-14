class Bid < ApplicationRecord
  belongs_to :project
  belongs_to :freelancer, class_name: 'User'
  validates :value, presence: { message: 'must have a value' }
  validates :freelancer_id, uniqueness: { scope: :project_id, message: 'you already placed a bid' }
end
