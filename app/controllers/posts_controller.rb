class PostsController < ApplicationController
  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".success"
    else
      flash[:danger] = t ".fail"
    end
    redirect_back fallback_location: root_path
  end

  private

  def post_params
    params.require(:post).permit :title, :content, :picture
  end
end
