module DeviseHelper
  def devise_error_messages!
    return "" unless devise_error_messages?

    messages = resource.errors.full_messages.map{|msg| content_tag(:li, msg)}.join
    sentence = I18n.t("errors.messages.not_saved",
      count: count_errors,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="error-explanation">
      <h2>#{sentence}</h2>
      <ul class = "err-messages">#{messages}</ul>
    </div>
    HTML

    html.html_safe
  end

  def devise_error_messages?
    !resource.errors.empty?
  end

  def count_errors
    resource.errors.count
  end
end
