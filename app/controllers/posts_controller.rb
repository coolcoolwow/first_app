class PostsController < ApplicationController

	before_action :authenticate_user, only: [:create, :index, :destroy]

	def index
		if params[:search].blank?
			@posts = Post.from_followed_users(current_user).page(params[:page]).order('created_at DESC')
		else
			@posts = Post.search do
				fulltext params[:search]
				paginate(page: params[:page])
			end.results
		end
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(create_params)
		if @post.save
			flash[:success] = "Posted successfully"
			redirect_to posts_path
		else
			render "new"
		end
	end

	def destroy
		@post = Post.find(params[:id])
		if current_user?(@post.user)
			@post.destroy
			flash[:success] = "Post deleted"
		else
			flash[:error] = "You cannot delete that post"
		end
		redirect_to posts_path
	end

	private

	def create_params
		params.require(:post).permit(:content)
	end

end
