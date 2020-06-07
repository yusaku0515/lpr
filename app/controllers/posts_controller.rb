class PostsController < ApplicationController


  def new
    @post = Post.new
  end

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.save
    redirect_to posts_path
  end

  def update
  end

  def destroy
  end

  private
  def post_params
    params.require(:post).permit(:title, :post_text, {post_images: []}, :user_id, :local_id)
  end
end
