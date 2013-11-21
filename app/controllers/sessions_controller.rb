class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    user = User.authorize(params[:email], params[:encrypted_password])
    if user
      user.last_login_time = DateTime.now
      return render json: user, only: [:auth_token, :id]
    else
      return render_blank(500)
    end
  end

  def destroy
    current_user.deauthorize
  end
end
