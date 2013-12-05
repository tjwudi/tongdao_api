class AddTokenSetForUser < ActiveRecord::Migration
  def up
    remove_column :users, :auth_token
    remove_column :users, :last_auth_time

    create_table :tokens do |t|
      t.string :token, :null => false
      t.references :user

      t.timestamps
    end
  end

  def down
    add_column :users, :auth_token, :string
    add_column :users, :last_auth_time, :timestamp

    drop_table :tokens
  end
end
