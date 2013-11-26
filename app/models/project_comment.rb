# -*- encoding : utf-8 -*-
class ProjectComment < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
end
