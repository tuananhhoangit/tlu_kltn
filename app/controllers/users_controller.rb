class UsersController < ApplicationController
  load_resource

  def index
    @users =
      User.select(:id, :name, :email, :avatar).users_sort.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def show
    all_posts = @user.posts
    @posts = all_posts.select(:id, :title, :content, :picture, :user_id,
      :created_at).posts_sort.paginate page: params[:page],
      per_page: Settings.user.per_page
    @post = all_posts.build
  end
end
