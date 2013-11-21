class CreateStickersUsers < ActiveRecord::Migration
  def change
    create_table :stickers_users do |t|
      t.references :sticker, index: true
      t.boolean :read

      t.timestamps
    end
  end
end
