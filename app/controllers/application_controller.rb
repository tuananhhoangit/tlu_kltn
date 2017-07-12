class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def verify_admin
    if current_user.is_admin?
      flash.now[:success] = t "welcome_admin"
    else
      flash[:danger] = t "danger_not_admin"
      redirect_to root_path
    end
  end

  def valid_info object
    render file: "public/404.html", layout: false unless object
  end
end
