class AddMarkdownBodyToPosts < ActiveRecord::Migration[6.1]
  def change
    remove_column :posts, :body, :text
    add_column :posts, :markdown_body, :text
  end
end
