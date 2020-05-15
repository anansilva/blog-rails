class PostsController < ApplicationController
  def index
    @posts = Query::Posts.call(params[:tag])

    ::EventSourcing::Publishers::PageViewed.execute!(request, 'posts')
  end

  def show
    @post = Post.published.friendly.find(params[:id])

    ::EventSourcing::Publishers::PageViewed.execute!(request, 'post')
  end

  def new
    @post = Post.new
  end
end
