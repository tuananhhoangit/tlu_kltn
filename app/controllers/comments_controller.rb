class CommentsController < ApplicationController
  before_action :load_post, only: [:create, :destroy]

  def create
    @comment = @post.comments.build content: params[:comment][:content],
      user: current_user

    return unless @comment.save
    redirect_back fallback_location: root_path
  end

  def destroy
    @comment = @post.comments.find_by id: params[:id]

    if @comment.destroy
      flash[:success] = t ".comment_deleted"
    else
      flash[:danger] = t ".del-cmt-fail"
    end
    redirect_back fallback_location: root_path
  end

  private

  def load_post
    @post = Post.find_by id: params[:post_id]

    valid_info @post
  end
end
