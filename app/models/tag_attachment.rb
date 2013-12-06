# -*- encoding : utf-8 -*-
class TagAttachment < ActiveRecord::Base
  belongs_to :tag, counter_cache: :count_of_tag_attachments
  belongs_to :project
end
