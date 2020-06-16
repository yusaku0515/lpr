class PostsController < ApplicationController


  def new
    @post = Post.new
  end

  def index
    # タグ機能（絞り込み）
    if params[:tag_name]
       @posts = Post.tagged_with("#{params[:tag_name]}")
    else
       @posts = Post.all
       render 'index'
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    # コメント機能
    @comments = @post.comments
    @comment = @post.comments.build
    # いいね機能
    @like = Like.new
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
       redirect_to post_path(@post.id)
    else
       @posts = Post.all
       render 'index'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       redirect_to post_path(@post.id)
    else
       render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to user_path(@user.id), notice: "商品を削除しました"
  end


  private
  def post_params
    params.require(:post).permit(:title, :post_text, {post_images_images: []}, :user_id, :tag_list, :star)
  end


end
