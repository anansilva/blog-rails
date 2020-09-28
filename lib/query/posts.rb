module Query
  class Posts
    ALLOWED_STATUS = {
      'draft': 0,
      'published': 1
    }.with_indifferent_access

    def initialize(tag, status)
      @tag = tag
      @status = status
    end

    def self.call(tag = nil, status = nil)
      new(tag, status).result
    end

    def result
      return posts if @tag.blank?

      posts_filtered_by_tag
    end

    def posts
      Post
        .where(status: ALLOWED_STATUS[@status] || ALLOWED_STATUS.values)
        .order('created_at DESC')
    end

    def posts_filtered_by_tag
      posts
        .joins('left outer join tag_posts on tag_posts.post_id = posts.id')
        .joins('left outer join tags on tags.id = tag_posts.tag_id')
        .where('tags.name' => @tag)
    end
  end
end
