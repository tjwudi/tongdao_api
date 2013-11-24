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
