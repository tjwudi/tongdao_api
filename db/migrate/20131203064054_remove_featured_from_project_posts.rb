class RemoveFeaturedFromProjectPosts < ActiveRecord::Migration
  def change
    remove_column :project_posts, :featured
  end
end
