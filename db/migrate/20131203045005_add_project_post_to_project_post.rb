class AddProjectPostToProjectPost < ActiveRecord::Migration
  def change
    add_column :project_comments, :project_post_id, :integer
  end
end
