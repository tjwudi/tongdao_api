class PublicActivity < ActiveRecord::Base
  def self.per_page
    20
  end

  belongs_to :user
end
