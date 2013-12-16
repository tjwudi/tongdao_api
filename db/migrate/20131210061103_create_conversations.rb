class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :user
      t.boolean :is_read, :default => false
      t.references :user_opp

      t.timestamps
    end
  end
end
