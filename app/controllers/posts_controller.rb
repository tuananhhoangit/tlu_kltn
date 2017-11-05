class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @sidebar_posts_select = Post.select(:id, :title, :picture).left_outer_joins(:likes)
      .group("posts.id").order("count(likes.id) DESC")
    @sidebar_posts = @sidebar_posts_select.first 5
    if params[:search]
      @posts = Post.search_post(params[:search]).posts_sort.paginate page: params[:page],
        per_page: Settings.user.per_page
    elsif params[:most_like]
      @posts = Post.select(:id, :title, :content, :created_at, :picture, :user_id).left_outer_joins(:likes)
        .group("posts.id").order("count(likes.id) DESC").paginate page: params[:page],
        per_page: Settings.user.per_page
    else
      posts_select = Post.select(:id, :title, :content, :created_at, :picture, :user_id).posts_sort
      @posts = posts_select.paginate page: params[:page],
        per_page: Settings.user.per_page
      @edit_post_forms = posts_select.paginate page: params[:page],
        per_page: Settings.user.per_page
    end
  end

  def create
    @post = current_user.posts.build post_params

    if @post.save
      flash[:success] = t ".post_created"
    else
      @feed_items = []
      flash[:danger] = t ".fail_to_create"
    end
    redirect_back fallback_location: root_path
  end

  def show
    @comments = @post.comments
    posts_select = Post.select(:id, :title, :content, :created_at, :picture, :user_id).posts_sort
    @edit_post_forms = posts_select.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def update
    if @post.update_attributes(title: params[:title], content: params[:content])
      render json: {status: :success}
    else
      render json: {status: :error}
    end
  end

  def destroy
    if @post.destroy
      render json: {status: :success}
    else
      render json: {status: :error}
    end
  end

  private

  def post_params
    params.require(:post).permit :id, :title, :content, :created_at, :picture, :all_tags
  end
end
