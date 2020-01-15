class PostsController < ApplicationController
  def index
    @posts = Query::Posts.call(params[:tag])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end
end
