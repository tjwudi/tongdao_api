# -*- encoding : utf-8 -*-
class Membership < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
end
