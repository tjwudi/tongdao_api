class CreateStickers < ActiveRecord::Migration
  def change
    create_table :stickers do |t|
      t.references :project, index: true
      t.references :user, index: true
      t.text :content
      t.boolean :requires_feedback
      t.string :files

      t.timestamps
    end
  end
end
