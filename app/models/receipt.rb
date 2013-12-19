class Receipt < ActiveRecord::Base
  belongs_to :sender, :class_name => "User"

  has_and_belongs_to_many :conversations
end
