# -*- encoding : utf-8 -*-
class ProjectPost < ActiveRecord::Base
  belongs_to :project

  has_many :project_comments
end
