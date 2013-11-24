class UsersController < ApplicationController
  skip_before_action :authenticate, only: [:create, :count]

  def index 
    return render_blank(500) unless params.include?(:auto_complete_word) && params.include?(:count)
    return render json: User.select("nickname, avatar, school, speciality, gender, id").where("nickname LIKE '%#{params[:auto_complete_word]}%'").limit(params[:count]), status: 200
  end

  def create
    begin
      user = User.create(params.permit(:nickname, :email, :encrypted_password))
    rescue
      p "user creation failed"
      render_blank(500)
      return
    end
    token = Token.new_for(user)
    return render :json => token, status: 201
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

  def follow
  end

  def unfollow
  end

  def can_follow
  end

  def followed_me
  end

  def followers
  end

  def following
  end
end
