class MessagesController < ApplicationController
  def index
    @user = current_user
    @conversations = @user.mailbox.conversations.page(params[:page])

    render "messages/index"
  end

  def show
    # Show conversation with :id => params[:id]
    @user = current_user
    @conversation = @user.mailbox.conversations.find(params[:id])
    @receipts = @conversation.receipts_for(@user).page(params[:page])
  end
end
