class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create, :count]

  def index 
    return render_blank(500) unless params.include?(:auto_complete_word) && params.include?(:count)
    return render json: User.select("nickname, avatar, school, speciality, gender, id").where("nickname LIKE '%#{params[:auto_complete_word]}%'").limit(params[:count]), status: 200
  end

  def create
    begin
      user = User.new(params.permit(:nickname, :email, :encrypted_password))
      user.generate_authentication_token
      user.save
      user.reload
    rescue
      p "user creation failed"
      render_blank(500)
      return
    end
    return render json: user, only: [:auth_token, :id]
  end

  def update
    current_user.nickname = params[:nickname] if params.include? :nickname
    current_user.gender = params[:gender] if params.include? :gender
    current_user.contact = params[:contact] if params.include? :contact
    current_user.school = params[:school] if params.include? :school
    current_user.speciality = params[:speciality] if params.include? :speciality
    current_user.avatar = params[:avatar] if params.include? :avatar
    current_user.encrypted_password = params[:encrypted_password] if params.include? :encrypted_password

    begin
      current_user.save
      return render_blank(200)
    rescue
      p "unable to update user information"
      return render_blank(500)
    end
  end

  def count
    return render json: { count: User.all.count }, status: 200
  end

  def toggle_follow
    current_user.toggle_follow!(User.find(params[:id]))
    render_blank(201)
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
