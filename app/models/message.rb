class Message < ApplicationRecord
  belongs_to :user
  belongs_to :conversation
  validates_presence_of :content
  has_many_attached :documents
end
