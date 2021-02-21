class RemoveMarkdownBodyFromPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :markdown_body, :text
  end
end
