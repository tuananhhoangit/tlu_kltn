class StaticPagesController < ApplicationController
  def home
    return unless user_signed_in?
    @feed_items = current_user.feed.select(:id, :title, :content, :picture,
      :user_id, :created_at).order(created_at: :desc).paginate page: params[:page],
      per_page: Settings.post.post_per_page
    @post = current_user.posts.build
  end
end
