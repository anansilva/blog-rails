class ChangePostsIntroFieldType < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :intro, :text
  end
end
