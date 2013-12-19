class CreateConversationsAndReceipts < ActiveRecord::Migration
  def change
    create_table :conversations_receipts do |t|
      t.belongs_to :conversation
      t.belongs_to :receipt
    end
  end
end
