class Message < ApplicationRecord
  belongs_to :user,inverse_of: :messages
  belongs_to :conversation
  validates :content, presence: true, if: :documents?
  has_many_attached :documents

  def documents?
    documents.empty?
  end
end
