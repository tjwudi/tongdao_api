class Project < ActiveRecord::Base
  acts_as_likeable

  has_many :memberships
  has_many :users, through: :memberships, source: :user

  has_many :project_comments

  has_many :project_likes
  has_many :liked_users, through: :project_likes, source: :user

  has_many :project_posts

  has_many :stickers

  has_many :boxes

  validates :title, presence: true
  validates :school, presence: true
  validates :state, presence: true

  def as_json(option = {})
    super(:include => [:tags => { :only => [:name] }]   )
  end
end
