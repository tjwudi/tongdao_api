class CreateOrganizations < ActiveRecord::Migration
  def up
    create_table :organizations do |t|
      t.string :name
      t.text :introduction
      t.string :avatar
      t.references :administrator

      t.timestamps
    end

    # Add organization column to users table
    add_column :users, :organization_id, :integer
  end

  def down
    remove_column :users, :organization_id
    drop_table :organizations 
  end
end
