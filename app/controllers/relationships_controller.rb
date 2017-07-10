class RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]

  def create
    @user = User.find_by id: params[:id]
    valid_info @user
    if current_user.follow @user
      render json: {status: :success, btn_html: render_to_string(partial: "users/follow_form", layout: false)}
    else
      render json: {status: :error}
    end
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    valid_info @user
    if current_user.unfollow @user
      render json: {status: :success, btn_html: render_to_string(partial: "users/follow_form", layout: false)}
    else
      render json: {status: :error}
    end
  end
end
