# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create, :count]

  def index 
    return render_blank(500) unless params.include?(:auto_complete_word) && params.include?(:count)
    return render json: User.where("nickname LIKE '%#{params[:auto_complete_word]}%'").limit(params[:count]).as_json
  end

  def create
    begin
      user = User.new(params.permit(:nickname, :email, :encrypted_password))
      user.generate_authentication_token
      user.last_auth_time=DateTime.now
      user.save
      user.reload
    rescue
      p "user creation failed"
      render_blank(500)
      return
    end
    return render json: user, type: :auth_token_only
  end

  def update
    current_user_cache = current_user
    current_user_cache.nickname = params[:nickname] if params.include? :nickname
    current_user_cache.gender = params[:gender] if params.include? :gender
    current_user_cache.contact = params[:contact] if params.include? :contact
    current_user_cache.school = params[:school] if params.include? :school
    current_user_cache.speciality = params[:speciality] if params.include? :speciality
    current_user_cache.avatar = params[:avatar] if params.include? :avatar
    current_user_cache.experence = params[:experence] if params.include? :experence
    current_user_cache.major = params[:major] if params.include? :major
    

    begin
      current_user_cache.save
      return render json: current_user_cache.as_json
    rescue
      p "unable to update user information"
      return render_blank(500)
    end
  end

  def count
    return render json: { count: User.all.count }, status: 200
  end

  def toggle_follow
    current_user_cache = current_user
    target_user = User.find(params[:id])

    if current_user_cache.follows?(target_user) 
      current_user_cache.unfollow_user!(target_user)
    else
      current_user_cache.follow_user!(target_user)
    end
    render_blank(200)
  end

  def followship
    current_user_cache = current_user
    target_user = User.find(params[:id])
    render_blank(500) if current_user_cache.id == target_user.id

    result = { status: 0 }
    b_followed = target_user.follows?(current_user_cache)
    b_following = current_user_cache.follows?(target_user)
    
    if b_followed && b_following
      result[:status] = 3
    elsif b_followed && !b_following
      result[:status] = 2
    elsif !b_followed && b_following
      result[:status] = 1
    else
      result[:status] = 0
    end
      
    render json: result
  end

end
