class CreateProjectPosts < ActiveRecord::Migration
  def change
    create_table :project_posts do |t|
      t.references :project, index: true
      t.boolean :featured
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end
