# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create, :count, :followers, :followings]

  def index 
    return render_blank(500) unless params.include?(:auto_complete_word) && params.include?(:count)
    @users = User.where("nickname LIKE '%#{params[:auto_complete_word]}%'").limit(params[:count])

    render "users/index"
  end

  def create
    @user = User.create(params.permit(:nickname, :email, :encrypted_password))

    render "users/show"
  end

  def update
    @user = current_user
    
    @user.nickname = params[:nickname] if params.include? :nickname
    @user.gender = params[:gender] if params.include? :gender
    @user.contact = params[:contact] if params.include? :contact
    @user.school = params[:school] if params.include? :school
    @user.speciality = params[:speciality] if params.include? :speciality
    @user.avatar = params[:avatar] if params.include? :avatar
    @user.experence = params[:experence] if params.include? :experence
    @user.major = params[:major] if params.include? :major
    
    @user.save
      
    render "users/show"
  end

  def count
    @count = User.all.count 

    render "shared/count"
  end

  def toggle_follow
    current_user_cache = current_user
    target_user = User.find(params[:id])

    if current_user_cache.follows?(target_user) 
      current_user_cache.unfollow_user!(target_user)
    else
      current_user_cache.follow_user!(target_user)
    end
    
    @state = get_followship(current_user_cache, target_user)

    render "shared/state"
  end

  def followship
    current_user_cache = current_user
    target_user = User.find(params[:id])
  
    @state = get_followship(current_user_cache, target_user)

    render "shared/state"
  end

  def followers
    @users = User.find(params[:id]).followers_relation(User).page(params[:page])

    render "users/index"
  end

  def followings
    @users = User.find(params[:id]).followables_relation(User).page(params[:page])

    render "users/index"
  end

  private
  def get_followship(current_user_cache, target_user)
    b_followed = target_user.follows?(current_user_cache)
    b_following = current_user_cache.follows?(target_user)
    
    if b_followed && b_following
      return 3
    elsif b_followed && !b_following
      return 2
    elsif !b_followed && b_following
      return 1
    else
      return 0
    end
    return result
  end

end
