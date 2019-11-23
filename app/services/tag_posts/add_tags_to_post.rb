class TagPosts::AddTagsToPost
  def initialize(post, tags)
    @post = post
    @tags = tags
  end

  def self.execute!(post, tags)
    new(post, tags).add_tags
  end

  def add_tags
    @tags.each do |tag_name|
      tag = TagRepository.create_tag(tag_name)
      TagPostRepository.create_tag_post(@post, tag)
    end
  end
end
