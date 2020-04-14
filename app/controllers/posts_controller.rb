class PostsController < ApplicationController
  def index
    @posts = Query::Posts.call(params[:tag])

    ::EventSourcing::Publishers::ViewedPage.execute!(request, 'posts')
  end

  def show
    @post = Post.published.friendly.find(params[:id])

    ::EventSourcing::Publishers::ViewedPage.execute!(request, 'post')
  end

  def new
    @post = Post.new
  end
end
