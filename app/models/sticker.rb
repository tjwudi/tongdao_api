class Sticker < ActiveRecord::Base
  belongs_to :project
  belongs_to :user

  has_many :stickers_users
  has_many :related_users, through: :stickers_users, source: :user

  has_and_belongs_to_many :boxes
end
