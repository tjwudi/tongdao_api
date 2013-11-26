# -*- encoding : utf-8 -*-
class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name, index: true
      t.integer :count_of_tag_attachments, default: 0, null: false

      t.timestamps
    end
    add_index :tags, :name
  end
end
