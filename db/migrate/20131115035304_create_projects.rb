# -*- encoding : utf-8 -*-
class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :category
      t.string :school
      t.string :state
      t.text :summary
      t.string :feature_photo
      t.integer :count_of_views, default: 0, null: false
      t.integer :count_of_likes, default: 0, null: false

      t.timestamps
    end
  end
end
