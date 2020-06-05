class CommentsController < ApplicationController


	def create
	    @post = Post.find(params[:post_id])
	    #投稿に紐づいたコメントを作成
	    @comment = @post.comments.build(comment_params)
	    @comment.user_id = current_user.id
	    @comment_post = @comment.post
	    if @comment.save
	      #通知の作成
	      @comment_post.create_notification_comment!(current_user, @comment.id)
	      render :index
	    end
    end

	def destroy
	end
	
end
