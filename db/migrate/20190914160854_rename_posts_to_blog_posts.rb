class RenamePostsToBlogPosts < ActiveRecord::Migration[6.0]
  def change
    rename_table :posts, :blog_posts
  end
end
