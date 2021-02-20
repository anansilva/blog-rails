class Post < ApplicationRecord
  extend FriendlyId
  friendly_id :title, use: :history

  has_many :tag_posts, dependent: :destroy
  has_many :tags, through: :tag_posts

  has_rich_text :body
  has_one_attached :cover_image

  validates :title, presence: true
  validates :intro, presence: true
  # validates :body, presence: true

  enum status: { draft: 0, published: 1 }
end
