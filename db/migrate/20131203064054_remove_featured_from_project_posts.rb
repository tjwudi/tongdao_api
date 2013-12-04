class RemoveFeaturedFromProjectPosts < ActiveRecord::Migration
  def up
    remove_column :project_posts, :featured
  end

  def down
    add_column :project_posts, :featured, :boolean
  end
end
