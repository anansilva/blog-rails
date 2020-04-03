class PostsController < ApplicationController
  def index
    @posts = Query::Posts.call(params[:tag])

    ::EventSourcing::PublishService
      .execute!('viewed_page', event_payload, 'posts')
  end

  def show
    @post = Post.published.friendly.find(params[:id])

    ::EventSourcing::PublishService
      .execute!('viewed_page', event_payload, 'post')
  end

  def new
    @post = Post.new
  end

  def event_payload
    { page: request.original_url }
  end
end
