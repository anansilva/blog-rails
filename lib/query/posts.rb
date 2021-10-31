module Query
  class Posts
    def initialize(tag, status)
      @tag = tag
      @status = status
    end

    def self.call(tag: nil, status: nil)
      new(tag, status).result
    end

    def result
      Post
        .then(&method(:filter_by_tag))
        .then(&method(:filter_by_status))
        .then(&method(:order))
    end

    private

    def filter_by_tag(posts)
      return posts unless @tag

      posts
        .joins('left outer join tag_posts on tag_posts.post_id = posts.id')
        .joins('left outer join tags on tags.id = tag_posts.tag_id')
        .where('tags.name' => @tag)
    end

    def filter_by_status(posts)
      return posts unless @status

      posts.where(status: Post.statuses[@status])
    end

    def order(posts)
      posts.order('published_at DESC')
    end
  end
end
