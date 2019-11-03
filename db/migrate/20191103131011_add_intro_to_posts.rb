class AddIntroToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :intro, :string, limit: 255
  end
end
