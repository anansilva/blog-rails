module Admin
  class PostsController < ApplicationController
    before_action :authenticate_user!

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)

      if @post.save!
        ::Tags::UpdatePostTags.call(@post, tag_names)
        redirect_to admin_post_path(@post),
                    notice: 'Post was successfully created.'
      else
        render :new
      end
    end

    def edit
      @post = Post.friendly.find(params[:id])

      render :new
    end

    def update
      @post = Post.friendly.find(params[:id])

      if @post.update!(post_params)
        ::Tags::UpdatePostTags.call(@post, tag_names)
        redirect_to admin_post_path(@post),
                    notice: 'Post was successfully updated.'
      else
        render :new
      end
    end

    def publish
      @post = Post.find(params[:id])

      if ::Posts::PublishPost.call(@post)
        redirect_to admin_post_path(@post),
                    notice: 'Post was published'
      else
        redirect_to admin_post_path(@post),
                    notice: 'Post is still draft. Maybe something is missing?'
      end
    end

    def unpublish
      @post = Post.find(params[:id])

      if @post.draft!
        redirect_to admin_post_path(@post), notice: 'Post is now a draft'
      else
        redirect_to admin_post_path(@post)
      end
    end

    def destroy
      post = Post.find(params[:id])
      post_title = post.title

      if post.destroy
        redirect_to admin_posts_path,
                    notice: "#{post_title} was successfully destroyed."
      else
        redirect_to admin_posts_path
      end
    end

    def show
      @post = Post.friendly.find(params[:id])

      render 'posts/show', post: @post
    end

    def index
      @posts = Query::Posts.call(tag: params[:tag])

      render 'admin/posts/index', posts: @posts
    end

    private

    def tag_names
      tag_params.fetch(:tags, '').split(', ')
    end

    def tag_params
      params.require(:post).permit(:tags)
    end

    def post_params
      params.require(:post).permit(:title, :body, :intro, :cover_image, :keywords)
    end
  end
end
