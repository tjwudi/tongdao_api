class CreatePublicActivities < ActiveRecord::Migration
  def change
    create_table :public_activities do |t|

      t.timestamps
    end
  end
end
