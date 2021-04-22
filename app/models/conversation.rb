class Conversation < ApplicationRecord
  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User'
  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, scope: :recipient_id

  scope :my_conversations, ->(current_user) { where('sender_id = ? OR recipient_id = ?', current_user.id, current_user.id).joins(:messages) }
  scope :between, ->(sender_id, recipient_id) { where('(conversations.sender_id = ? AND conversations.recipient_id = ?) OR (conversations.recipient_id = ? AND conversations.sender_id = ?)', sender_id, recipient_id, sender_id, recipient_id) }
  scope :total_unread_messages_count, ->(current_user) { where('sender_id = ? OR recipient_id= ? ', current_user.id, current_user.id).joins(:messages).where('messages.read = ? AND user_id !=?  ', false, current_user.id).count }

  def unread_message_count(current_user)
    messages.where('user_id != ? AND read = ?', current_user.id, false).count
  end
end
