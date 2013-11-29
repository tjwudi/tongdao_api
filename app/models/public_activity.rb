class PublicActivity < ActiveRecord::Base
  def self.per_page
    20
  end
end
