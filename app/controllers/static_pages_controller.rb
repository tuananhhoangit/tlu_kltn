class StaticPagesController < ApplicationController
  def home
    return unless user_signed_in?
    @posts = current_user.posts.select(:id, :title, :content, :picture, :user_id,
      :created_at).posts_sort.paginate page: params[:page],
      per_page: Settings.user.per_page
    @post = current_user.posts.build
  end
end
