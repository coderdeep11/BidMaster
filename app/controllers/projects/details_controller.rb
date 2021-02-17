module Projects
  class DetailsController < ApplicationController
    def index
      @project = Project.find(params[:project_id])
      @bids = @project.bids
      @shortlisted = @bids.where('(aasm_state =?  OR aasm_state =? )', 'awarded', 'accepted')
      @rejected = @bids.where(aasm_state: 'rejected')
      @conversation = Conversation.where('sender_id =? OR recipient_id =?', current_user.id, current_user.id).first
    end
  end
end
