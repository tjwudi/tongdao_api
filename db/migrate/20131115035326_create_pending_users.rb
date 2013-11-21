class CreatePendingUsers < ActiveRecord::Migration
  def change
    create_table :pending_users do |t|
      t.string :email, uniqueness: true, null: false

      t.timestamps
    end
  end
end
