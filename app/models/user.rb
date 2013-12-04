# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  acts_as_liker
  acts_as_followable
  acts_as_follower

  has_many :memberships
  has_many :projects, through: :memberships, source: :project

  has_many :project_comments

  has_many :project_likes
  has_many :liked_projects, through: :project_likes, source: :project

  has_many :public_activities
  
  def self.per_page
    return 15
  end


  def self.authorize(email, encrypted_password)
    user = User.find_by email: email, encrypted_password: encrypted_password
    if user 
      user.generate_authentication_token if user.auth_token.nil?
      user.save
      return user
    else
      return nil
    end
  end

  def follow_user!(user = nil)
    return false if user.nil?
    self.follow!(user)
    self.count_of_followings = self.count_of_followings + 1
    user.count_of_followers = user.count_of_followers + 1
    user.save
    self.save
  end

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

end
