class AddIsReadToConversation < ActiveRecord::Migration
  def up
    add_column :conversations, :user_alpha_is_read, :boolean
    add_column :conversations, :user_beta_is_read, :boolean
  end

  def down
    remove_column :conversations, :user_alpha_is_read
    remove_column :conversations, :user_beta_is_read
  end
end
