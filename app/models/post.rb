class Post < ApplicationRecord
  has_rich_text :body
  has_one_attached :cover_image

  validates :title, presence: true
  validates :body, presence: true
  validates_length_of :intro, maximum: 255
end
