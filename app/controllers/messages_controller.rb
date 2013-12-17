class MessagesController < ApplicationController
  def create
    @current_user = current_user
    @target_user = User.find(params[:id])
    @current_user.send_message(@target_user, params[:content])
  end

  def list_conversations
    @conversations = current_user.conversations
    render "messages/conversations"
  end

  def list_receipts
    conversation = current_user.conversations.find_by(:user_opp_id => params["id"]) # params["id"] is target user id
    @receipts = conversation.receipts
    render "messages/receipts"
  end
end
