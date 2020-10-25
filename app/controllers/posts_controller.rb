class PostsController < ApplicationController
  def index
    @posts = ::Query::Posts.call(params[:tag], 'published')

    ::EventSourcing::Publishers::HomePageViewed.call(request, params[:tag])
  end

  def show
    @post = Post.published.friendly.find(params[:id])

    ::EventSourcing::Publishers::PostViewed.call(request, @post)
  end

  def share
    @post = Post.published.friendly.find(params[:id])

    social_media_url =
      ::Services::MountShareUrl.call(@post, post_url(@post), params[:social_media])

    ::EventSourcing::Publishers::PostShared.call(request, @post)

    redirect_to social_media_url
  end
end
