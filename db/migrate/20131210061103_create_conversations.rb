class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.references :user_alpha
      t.references :user_beta

      t.timestamps
    end
  end
end
