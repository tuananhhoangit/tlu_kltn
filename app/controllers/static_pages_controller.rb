class StaticPagesController < ApplicationController
  def home
    return unless user_signed_in?
    @feed_items = current_user.feed.select(:id, :title, :content, :picture,
      :user_id, :created_at).order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.post.post_per_page
    @post = current_user.posts.build
    @sidebar_posts_select = Post.select(:id, :title, :picture).left_outer_joins(:likes)
      .group("posts.id").order("count(likes.id) DESC")
    @sidebar_posts = @sidebar_posts_select.first 5
    @edit_post_forms = current_user.feed.select(:id, :title, :content, :picture,
      :user_id, :created_at).order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.post.post_per_page
  end
end
