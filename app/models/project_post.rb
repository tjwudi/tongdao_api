# -*- encoding : utf-8 -*-
class ProjectPost < ActiveRecord::Base
  belongs_to :project

  has_many :project_comments
  
  def set_as_featured_post
    self.project.featured_post = self
  end
end
