class CommentsController < ApplicationController
  before_action :load_post, only: [:create, :update, :destroy]
  before_action :load_comment, only: [:update, :destroy]

  def create
    @comment = @post.comments.build content: params[:comment][:content],
      user: current_user

    if @comment.save
      render json: {status: :success, html: render_to_string(@comment)}
    else
      render json: {status: :error}
    end
  end

  def update
    if @comment.update_attributes comment_params
      render json: {status: :success}
    else
      render json: {status: :error}
    end
  end

  def destroy
    if @comment.destroy
      render json: {status: :success}
    else
      render json: {status: :error}
    end
  end

  private

  def load_post
    @post = Post.find_by id: params[:post_id]

    valid_info @post
  end

  def load_comment
    @post = Post.find_by id: params[:post_id]
    @comment = @post.comments.find_by id: params[:id]

    valid_info @comment
  end

  def comment_params
    params.require(:comment).permit :content
  end
end
