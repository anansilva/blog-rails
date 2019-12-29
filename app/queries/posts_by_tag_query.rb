class PostsByTagQuery
  def initialize(tag = '')
    @tag = tag
  end

  def self.call(tag)
    new(tag).run_query
  end

  def run_query
    return Post.all if @tag.empty?

    Post
      .includes(tag_posts: :tag)
      .where('tags.name' => @tag)
  end
end
