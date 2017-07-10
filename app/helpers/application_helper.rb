module ApplicationHelper
  def full_title page_title = ""
    base_title = t ".title"
    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end

  def build_follow
    current_user.active_relationships.build
  end

  def destroy_follow user
    current_user.active_relationships.find_by followed_id: user.id
  end
end
