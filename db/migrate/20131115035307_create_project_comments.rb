# -*- encoding : utf-8 -*-
class CreateProjectComments < ActiveRecord::Migration
  def change
    create_table :project_comments do |t|
      t.references :project, index: true
      t.references :user, index: true
      t.text :content
      t.string :emotion

      t.timestamps
    end
  end
end
