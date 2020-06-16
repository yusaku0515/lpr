class SearchesController < ApplicationController

	def search
		@keyword = params[:keyword]
		@searched_posts = Post.search(params[:keyword])
	end
end
