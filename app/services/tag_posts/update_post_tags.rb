class TagPosts::UpdatePostTags
  def initialize(post, tags)
    @post = post
    @tags = tags
  end

  def self.execute!(post, tags)
    new(post, tags).update_tags
  end

  def update_tags
    add_tags
    remove_tags
  end

  private

  def add_tags
    return unless tags_to_add?

    tags_to_add.each do |tag|
      tag = TagRepository.create_tag(tag)
      TagPostRepository.create_tag_post(@post, tag)
    end
  end

  def remove_tags
    return unless tags_to_remove?

    tags_to_remove.each do |tag|
      tag = Tag.find_by(name: tag).destroy
      TagPost.where(post: @post, tag: tag).destroy_all
    end
  end

  def tags_to_add
    @tags_to_add ||= @tags - post_tags
  end

  def tags_to_add?
    tags_to_add.present?
  end

  def tags_to_remove
    @tags_to_remove ||= post_tags - @tags
  end

  def tags_to_remove?
    tags_to_remove.present?
  end

  def post_tags
    @post_tags ||= @post.tags.pluck(:name)
  end
end
