class CreateTagAttachments < ActiveRecord::Migration
  def change
    create_table :tag_attachments do |t|
      t.references :tag, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
