# -*- encoding : utf-8 -*-
class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.references :project, index: true
      t.references :user, index: true
      t.boolean :is_owner

      t.timestamps
    end
  end
end
