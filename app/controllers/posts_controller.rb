class PostsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def index
    @posts = Query::Posts.call(params[:tag])
  end

  def show
    @post = Post.published.friendly.find(params[:id])
  end

  def new
    @post = Post.new
  end

  private

  def not_found
    render "/errors/not_found.html.erb", status: 404
  end
end
