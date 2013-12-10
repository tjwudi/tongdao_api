# -*- encoding : utf-8 -*-
class Conversation < ActiveRecord::Base
  belongs_to :user_alpha, :class_name => "User", :foreign_key => "user_alpha_id"
  belongs_to :user_beta, :class_name => "User", :foreign_key => "user_beta_id"

  has_many :receipts
end
