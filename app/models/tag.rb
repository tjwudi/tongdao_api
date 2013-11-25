class Tag < ActiveRecord::Base
  has_many :tag_attachments, counter_cache: :count_of_tag_attachments
  has_many :projects, through: :tag_attachments, source: :project
end
