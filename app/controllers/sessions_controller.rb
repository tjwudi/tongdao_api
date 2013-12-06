# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    @user = User.authorize(params[:email], params[:encrypted_password])
    if @user
      @token = Token.create(token: generate_authentication_token, user: @user)
      @user.last_login_time = DateTime.now
      
      render "tokens/show"
    else
      return render_blank(403)
    end
  end

  def destroy
    @token.destroy
  end

  private

  def generate_authentication_token
    if Rails.env.production?
      return SecureRandom.hex(32)
    else
      return "theusertoken"
    end
  end
end
