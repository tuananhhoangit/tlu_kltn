class UsersController < ApplicationController
  load_resource

  def show
    @posts = @user.posts.select(:id, :title, :content, :picture, :user_id,
      :created_at).posts_sort.paginate page: params[:page],
      per_page: Settings.user.per_page
    @post = current_user.posts.build
  end
end
