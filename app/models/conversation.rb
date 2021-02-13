class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id

  def self.between(sender_id, recipient_id)
    Conversation.where('(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.recipient_id = ? AND conversations.sender_id = ?)', sender_id, recipient_id, sender_id, recipient_id)
  end

  def unread_message_count(current_user)
    messages.where('user_id != ? AND read = ?', current_user.id, false).count
  end
end
