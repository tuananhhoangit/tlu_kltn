class Admin::PostsController < ApplicationController
  def index
    post_select = Post.select(:id, :user_id, :created_at, :title)
    @posts = post_select.posts_sort.paginate page: params[:page],
      per_page: Settings.user.per_page
    @posts_size = post_select.size
  end

  def destroy
    @post = Post.find_by id: params[:id]

    if @post.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t".delete_fail"
    end
    redirect_back fallback_location: root_path
  end
end
