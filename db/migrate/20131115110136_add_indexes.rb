class AddIndexes < ActiveRecord::Migration
  def change
    add_index :users, [:nickname], unique: true
    add_index :users, [:school], unique: true
   
    add_index :projects, [:title]
    add_index :projects, [:category]
    add_index :projects, [:school]
    
    add_index :pending_users, [:email], unique: true
  end
end
