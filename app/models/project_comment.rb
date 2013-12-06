# -*- encoding : utf-8 -*-
class ProjectComment < ActiveRecord::Base
  belongs_to :project_post
  belongs_to :project
  belongs_to :user

  def self.per_page
    10
  end
end
