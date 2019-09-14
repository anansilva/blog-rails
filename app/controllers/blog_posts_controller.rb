class BlogPostsController < ApplicationController
  def index
    @posts = BlogPost.all
  end

  def show
  end
end
