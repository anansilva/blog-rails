class PostsController < ApplicationController
  def index
    @posts = Query::Posts.call(params[:tag])

    ::EventSourcing::Publishers::HomePageViewed.execute!(request, params[:tag])
  end

  def show
    @post = Post.published.friendly.find(params[:id])

    ::EventSourcing::Publishers::PostViewed.execute!(request, @post)
  end

  def new
    @post = Post.new
  end
end
