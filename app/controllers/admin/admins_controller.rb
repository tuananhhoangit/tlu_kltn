class Admin::AdminsController < ApplicationController
  before_action :authenticate_user!, :verify_admin

  def index
    user_select = User.select(:id, :name, :email, :avatar)
    @users = user_select.users_sort.paginate page: params[:page],
      per_page: Settings.user.per_page
    @users_size = user_select.size

    post_select = Post.select(:id, :title, :content, :picture)
    @posts = post_select.posts_sort.paginate page: params[:page],
      per_page: Settings.user.per_page
    @posts_size = post_select.size
  end
end
