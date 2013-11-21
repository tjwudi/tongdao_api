class PendingUsersController < ApplicationController
  skip_before_action :authenticate, only: [:create, :count, :destroy]

  def create
    if User.where(params.permit(:email)).count > 0
      p "email exists in activated emails list"
      return render_blank(409)
    end

    pending_user = PendingUser.create(params.permit(:email))
    return render json: pending_user, status: 201
  end

  def count 
    return render_blank(500) unless params.include?(:email)
    return render json: { count: PendingUser.where(params.permit(:email)).count }
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
