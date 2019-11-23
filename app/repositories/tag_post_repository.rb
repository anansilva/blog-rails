class TagPostRepository
  class << self
    def create_tag_post(post, tag)
      TagPost.find_or_create_by(post: post, tag: tag)
    end
  end
end
