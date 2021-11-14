class PostsController < ApplicationController
  include Pagination

  POSTS_PER_PAGE = 6.freeze

  def index
    @pagination, @posts = paginate(collection: posts, params: pagination_params)
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

  private

  def pagination_params
    params.merge(per_page: POSTS_PER_PAGE)
  end

  def posts
    ::Query::Posts.call(tag: params[:tag], status: 'published')
  end
end
