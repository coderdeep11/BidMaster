class ConversationsController < ApplicationController
  before_action :authenticate_user!
  def index
    @conversations = Conversation.where('sender_id = ? OR recipient_id = ?', current_user.id, current_user.id).joins(:messages).order('messages.created_at DESC').uniq
    @paginatable_array = Kaminari.paginate_array(@conversations).page(params[:page]).per(5)
    @users = User.where.not(id: current_user.id)
  end

  def create
    if Conversation.between(params[:sender_id], params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
      @messages = @conversation.messages.order('created_at asc')
      @message = @conversation.messages.new
    else
      @conversation = Conversation.new(conversation_params)
      @conversation.save
      @messages = @conversation.messages
      @message = @conversation.messages.new

      respond_to do |format|
        format.js {}
      end

    end
  end

  private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
