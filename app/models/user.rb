class User < ActiveRecord::Base
  acts_as_liker
  acts_as_followable
  acts_as_follower

  has_many :memberships
  has_many :projects, through: :memberships, source: :project

  has_many :project_comments

  has_many :project_likes
  has_many :liked_projects, through: :project_likes, source: :project


  def self.authorize(email, encrypted_password)
    user = User.find_by email: email, encrypted_password: encrypted_password
    if user 
      user.generate_authentication_token
      user.save
      return user
    else
      return nil
    end
  end

  # follow a user
  def follow_user!(user = nil)
    return false if user.nil?
    self.follow!(user)
    self.count_of_followings = self.count_of_followings + 1
    user.count_of_followers = user.count_of_followers + 1
    user.save
    self.save
  end

  # unfollow a user
  def unfollow_user!(user = nil)
    return false if user.nil?
    self.unfollow!(user)
    self.count_of_followings = self.count_of_followings - 1
    user.count_of_followers = user.count_of_followers - 1
    user.save
    self.save
  end

  def deauthorize
    self.auth_token = nil
    self.save
  end

  def generate_authentication_token
    if Rails.env.production?
      self.auth_token = SecureRandom.hex(32)
    else
      self.auth_token = "theusertoken"
    end
  end

  def as_json(options=nil)
    if options.nil? 
      return super({})
    elsif options[:type]==:auth_token_only
      return super({:only => [:id, :auth_token]})
    elsif options[:type]==:need_auth_token
      return super({:except => [:encrypted_password, :contact]})
    else
      return super({:except => [:encrypted_password, :contact, :auth_token]})
    end
  end


end
