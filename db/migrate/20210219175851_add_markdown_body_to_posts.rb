class AddMarkdownBodyToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :markdown_body, :text
  end
end
