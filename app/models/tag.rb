# -*- encoding : utf-8 -*-
class Tag < ActiveRecord::Base
  has_many :tag_attachments
  has_many :projects, through: :tag_attachments, source: :project
end
