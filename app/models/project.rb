class Project < ActiveRecord::Base
  # Can be liked by User
  acts_as_likeable

  # Pagination 
  def self.per_page
    return 15
  end

  has_many :memberships
  has_many :users, through: :memberships, source: :user

  has_many :project_comments

  has_many :tag_attachments
  has_many :tags, through: :tag_attachments, source: :tag

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
