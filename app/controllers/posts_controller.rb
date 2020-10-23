class PostsController < ApplicationController
  def index
    @posts = ::Query::Posts.call(params[:tag], 'published')

    ::EventSourcing::Publishers::HomePageViewed.call(request, params[:tag])
  end

  def show
    @post = Post.published.friendly.find(params[:id])

    ::EventSourcing::Publishers::PostViewed.call(request, @post)
  end
end
