class PostsController < ApplicationController
  def index
    @posts = Query::Posts.call(params[:tag])

    stream_name = 'posts'

    event = ::EventSourcing::Events::ViewedPage.new(data: {
      page: 'index'
    })

    event_store.publish(event, stream_name: stream_name)
  end

  def show
    @post = Post.published.friendly.find(params[:id])
  end

  def new
    @post = Post.new
  end

  private

  def event_store
    Rails.configuration.event_store
  end
end
