module Posts
  class PublishPost
    include Services::Callable

    receive :post

    def result
      @post.update(
        status: 'published',
        published_at: @post.published_at || Time.now
      )
    end
  end
end
