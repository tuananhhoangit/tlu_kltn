class UsersController < ApplicationController
  load_resource

  def index
    users_select = User.select(:id, :name, :email, :avatar).users_sort
    @users = users_select.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def show
    @posts = @user.posts.select(:id, :title, :content, :picture, :user_id,
      :created_at).order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.user.per_page
    @post = @user.posts.build
  end

  def destroy
    if @user.destroy
      flash[:success] = t ".user_deleted"
    else
      flash[:danger] = t ".fail_to_delete"
    end
    redirect_to admin_root_url
  end

  def following
    @title = t ".following"
    users_select = @user.following.select(:id, :email, :name).order(id: :asc)
    @users = users_select.paginate page: params[:page]
    render :show_follow
  end

  def followers
    users_select = @user.followers.select(:id, :email, :name).order id: :asc
    @users = users_select.paginate page: params[:page]
    render :show_follow
  end

  private

  def load_user
    @user = User.find_by id: params[:id]

    valid_info @user
  end
end
