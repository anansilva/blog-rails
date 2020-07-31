class IncreasePostsIntroLimit < ActiveRecord::Migration[6.0]
  def change
    change_column :posts, :intro, :string, limit: 500
  end
end
