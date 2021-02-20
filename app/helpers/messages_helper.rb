module MessagesHelper
  def authorize_messages(conversation)
    conversation.sender == current_user || conversation.recipient == current_user
  end
end
