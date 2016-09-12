module ApplicationHelper
  def devise_error_messages
    return '' if resource.errors.empty?
    
    messages = resource.errors.full_messages.map { #this overrides devise error messages
      |msg| content_tag(:li, msg) }.join
    html = <<-HTML
<div class = "callout alert" data-closable>
  <button class="close-button" aria-label="dismiss alert" type="button" data-close><span aria-hidden="true"> &times;<span></button>
  <%= content_tag :div, msg if msg.is_a?(String) %>
</div>
HTML
    html.html_safe
  end
end
