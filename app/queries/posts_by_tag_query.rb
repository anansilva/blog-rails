class PostsByTagQuery
  def initialize(tag = '')
    @tag = tag
  end

  def all
    return Post.all if @tag.empty?

    Post
      .includes(tag_posts: :tag)
      .where('tags.name' => @tag)
  end
end
