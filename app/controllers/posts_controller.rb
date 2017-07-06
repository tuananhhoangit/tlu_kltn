class PostsController < ApplicationController
  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".success"
      redirect_back fallback_location: root_path
    else
      flash[:danger] = t ".fail"
      redirect_back fallback_location: root_path
    end
  end

  private

  def post_params
    params.require(:post).permit :title, :content, :picture
  end
end
