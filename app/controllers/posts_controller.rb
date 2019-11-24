class PostsController < ApplicationController
  rescue_from ::Errors::InvalidAttributes, with: :unprocessable_entity

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      TagPosts::AddTagsToPost.execute!(@post, tag_names)
      redirect_to post_path(@post), notice: 'Post was successfully created.'
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])

    render :new
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post_title = post.title

    if post.destroy
      redirect_to posts_url, notice: "#{post_title} was successfully destroyed."
    else
      redirect_to posts_path
    end
  end

  private

  def tag_names
    tag_params[:tags].split(', ')
  end

  def tag_params
    params.require(:post).permit(:tags)
  end

  def post_params
    params.require(:post).permit(:title, :body, :intro, :cover_image)
  end
end
