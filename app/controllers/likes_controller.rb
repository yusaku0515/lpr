class LikesController < ApplicationController

	def create
        @like = current_user.likes.create(post_id: params[:post_id])
	    @like.save
	    @post = Post.find(params[:post_id])
	    #通知の作成
	    @post.create_notification_by(current_user)
	    respond_to do |format|
	      format.html {redirect_to request.referrer}
	      format.js
	    end
	end

	def destroy
		@post = Post.find(params[:post_id])
	    @like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
	    @like.destroy
	end

end
