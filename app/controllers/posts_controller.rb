class PostsController < ApplicationController
  load_and_authorize_resource

  def create
    @post = current_user.posts.build(id: params[:id], title: params[:title], content: params[:content])

    if @post.save
      render json: {status: :success, html: render_to_string(@post)}
    else
      render json: {status: :error}
    end
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
end
