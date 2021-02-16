class FreelancerInfo < ApplicationRecord
  belongs_to :freelancer, class_name: 'User'
end
