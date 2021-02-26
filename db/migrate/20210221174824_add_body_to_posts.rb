class AddBodyToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :body, :text
  end
end
