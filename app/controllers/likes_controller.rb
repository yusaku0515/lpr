class LikesController < ApplicationController
	
	def create
	  like = current_user.likes.new(post_id: @post.id)
	  like.save
	  @post = Post.find(params[:post_id])
	  #通知の作成
	  @post.create_notification_by(current_user)
	  respond_to do |format|
	    format.html {redirect_to request.referrer}
	    format.js
	  end
	end

	def destroy
	end

end
