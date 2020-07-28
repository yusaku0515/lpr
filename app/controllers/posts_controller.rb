class PostsController < ApplicationController
  before_action :authenticate_user!, { only: [:edit, :show, :new] } # ログインしていないと見れない アクセス権限

  def new
    @post = Post.new
  end

  def index
    # タグ機能（絞り込み）
    if params[:tag_name]
      @posts = Post.tagged_with(params[:tag_name]).page(params[:page]).per(6)
    else
      @posts = Post.all.page(params[:page]).per(6)
    end
  end

  def show
    @post = Post.find(params[:id])
    @user = @post.user
    # PV値測定
    impressionist(@post, "message...")
    @page_views = @post.impressionist_count(:filter => :ip_address)
    # コメント機能
    @comments = @post.comments
    @comment = @post.comments.build
    # いいね機能
    @like = Like.new
  end

  def edit
    @post = Post.find(params[:id])
    if @post.user_id == current_user.id
      render 'edit'
    else
      redirect_to posts_path, notice: "現ユーザーが投稿したものでないので編集ページへアクセスできません"
    end
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      @post.post_images.each do |image|
        @tags = Vision.get_image_data(image.image)
      end
      @tags.each do |tag|
        @post.tags.create(name: tag)
      end
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
    params.require(:post).permit(:title, :post_text, { post_images_images: [] }, :user_id, :tag_list)
  end
end
