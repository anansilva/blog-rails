class Post < ApplicationRecord
  has_many :tag_posts, dependent: :destroy
  has_many :tags, through: :tag_posts

  has_rich_text :body
  has_one_attached :cover_image

  validates :title, presence: true
  validates :body, presence: true
  validates_length_of :intro, maximum: 255

  enum status: { draft: 0, published: 1 }
end
