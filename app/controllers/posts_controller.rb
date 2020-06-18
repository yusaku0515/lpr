class PostsController < ApplicationController
before_action :authenticate_user!,{only:[:edit]} #ログインしていないと見れない　アクセス権限　表示させたくない物を選択する

  def new
    @post = Post.new
  end

  def index
    # タグ機能（絞り込み）
    if params[:tag_name]
       @posts = Post.tagged_with("#{params[:tag_name]}")
    else
       @posts = Post.all.page(params[:page])
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
       redirect_to post_path(@post.id), notice: "投稿しました"
    else
       @posts = Post.all
       render 'new'
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
       redirect_to post_path(@post.id), notice: "投稿の編集内容を更新しました"
    else
       render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to root_path, notice: "投稿を削除しました"
  end


  private
  def post_params
    params.require(:post).permit(:title, :post_text, {post_images_images: []}, :user_id, :tag_list)
  end


end
