# -*- encoding : utf-8 -*-
class Conversation < ActiveRecord::Base
  belongs_to :user_opp, :class_name => "User", :foreign_key => "user_opp_id"
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"

  has_many :receipts
end
