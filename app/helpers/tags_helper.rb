module TagsHelper
  def published_tags
    Tag.joins(:tag_posts).pluck(:name)
  end
end
