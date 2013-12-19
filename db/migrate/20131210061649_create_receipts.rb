class CreateReceipts < ActiveRecord::Migration
  def change
    create_table :receipts do |t|
      t.text :content
      t.references :sender

      t.timestamps
    end
  end
end
