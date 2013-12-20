# -*- encoding : utf-8 -*-
class PendingUsersController < ApplicationController
  skip_before_action :authenticate, only: [:create, :count, :destroy]

  def create
    @pending_user = PendingUser.create(params.permit(:email))
    
    render "pending_users/show"
  end

  def exist 
    return render_blank(500) unless params.include?(:email)
    
    @state = 0
    @state = 1 if PendingUser.where(params.permit(:email)).count > 0
    @state = 2 if User.where(params.permit(:email)).count > 0

    render "shared/state"
  end

  def destroy
    return render_blank(500) unless params.include?(:id)
    begin
      pending_user = PendingUser.find_by(params.permit(:id))
      pending_user.destroy unless pending_user.nil?
    rescue
      p "delete pending user failed"
      return render_blank(500)
    end
    return render_blank
  end
end
