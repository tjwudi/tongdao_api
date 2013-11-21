class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|
      t.references :project, index: true
      t.string :title

      t.timestamps
    end
  end
end
