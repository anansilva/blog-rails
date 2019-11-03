class Post < ApplicationRecord
  has_rich_text :body

  validates :title, presence: true
  validates :body, presence: true
  validates_length_of :intro, maximum: 255
end
