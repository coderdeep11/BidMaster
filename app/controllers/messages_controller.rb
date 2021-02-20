class MessagesController < ApplicationController
  before_action :authenticate_user!
  include MessagesHelper
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
  end

  def index
    redirect_to conversations_path unless authorize_messages(@conversation)
    @messages = @conversation.messages.order('created_at asc')
    @messages.where('user_id != ? AND read = ?', current_user.id, false).update_all(read: true)
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(message_params)
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.html { redirect_to conversation_messages_path(@conversation) }

        format.js {}
      end

    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :user_id, documents: [])
  end
end
