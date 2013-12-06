# -*- encoding : utf-8 -*-
class Project < ActiveRecord::Base
  # Can be liked by User
  acts_as_likeable

  # Pagination 
  def self.per_page
    return 15
  end

  has_many :memberships, dependent: :destroy
  has_many :users, through: :memberships, source: :user

  has_many :project_comments, dependent: :destroy

  has_many :tag_attachments, dependent: :destroy
  has_many :tags, through: :tag_attachments, source: :tag

  has_many :project_posts, dependent: :destroy
  has_one :featured_post, :class_name => :ProjectPost

  validates :title, presence: true
  validates :school, presence: true
  validates :state, presence: true

  def toggle_membership!(user)
    membership = self.memberships.where(:user_id => user.id)
    
    if membership.count == 0
      self.users << user
    elsif membership.is_owner == false
      self.users.delete(user)
    end
    self.save
    self.reload
  end
end
