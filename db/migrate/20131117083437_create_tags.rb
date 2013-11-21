class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, index: true

      t.timestamps
    end
    add_index :tags, :name
  end
end
