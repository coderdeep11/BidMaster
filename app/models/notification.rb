class Notification < ApplicationRecord
  belongs_to :user,inverse_of: :notifications
  belongs_to :bid
  validates_uniqueness_of :user_id, scope: :bid_id
end
