class LikesController < ApplicationController
  before_action :load_post, only: [:create, :destroy]
  load_resource

  def create
    @like = @post.likes.build user: current_user

    if @like.save
      render json: {status: :success, likes_html: render_to_string(partial: "likes/like_form",
        locals: {post: @post}, layout: false)}
    else
      render json: {status: :error}
    end
  end

  def destroy
    if @like.destroy
      render json: {status: :success, likes_html: render_to_string(partial: "likes/like_form",
        locals: {post: @post}, layout: false)}
    else
      flash[:danger] = "Error"
    end
  end

  private

  def load_post
    @post = Post.find_by id: params[:post_id]

    valid_info @post
  end
end
