class MessagesController < ApplicationController
  def create
    @current_user = current_user
    @target_user = User.find(params[:id])
    @current_user.send_message(@target_user, params[:content])
  end
end
