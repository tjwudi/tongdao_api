class CreateBoxesStickers < ActiveRecord::Migration
  def change
    create_table :boxes_stickers do |t|
      t.references :sticker, index: true
      t.references :box, index: true

      t.timestamps
    end
  end
end
