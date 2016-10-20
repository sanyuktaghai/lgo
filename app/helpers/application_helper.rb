module ApplicationHelper
  def signed_in_user
    unless current_page? registration_step_path(:basic_details)
      html = <<-HTML
<p class="navbar-text">Signed in as #{current_user.email}.</p>
HTML
      html.html_safe
    end
  end
end
