class PostsController < ApplicationController
  def index
    @posts = ::Query::Posts.call(tag: params[:tag], status: 'published')
    @tag = params[:tag]
  end

  def show
    @post = Post.published.friendly.find(params[:id])
  end

  def rss_feed
    @posts = Post.published.last(10)
  end

  def share
    @post = Post.published.friendly.find(params[:id])

    social_media_url =
      ::Services::MountShareUrl.call(@post, post_url(@post), params[:social_media])

    redirect_to social_media_url
  end
end
