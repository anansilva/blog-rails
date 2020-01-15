module Query
  class Posts
    def initialize(tag)
      @tag = tag
    end

    def self.call(tag = nil)
      new(tag).result
    end

    def result
      return published_posts if @tag.blank?

      published_posts_filtered_by_tag
    end

    def published_posts
      Post.where(status: 'published')
    end

    def published_posts_filtered_by_tag
      published_posts
        .includes(tag_posts: :tag)
        .where('tags.name' => @tag)
    end
  end
end
