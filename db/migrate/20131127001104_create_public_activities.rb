class CreatePublicActivities < ActiveRecord::Migration
  def change
    create_table :public_activities do |t|
      t.references :user
      t.text :data
      t.timestamps
    end
  end
end
