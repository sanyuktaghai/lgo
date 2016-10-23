module DashboardHelper
  def user_photo(user)
    if @user.image?
      image_tag @user.image.url(:medium)
    elsif @user.image_file_name?
      image_tag(@user.largesquareimage)
    else
      link_to "Upload Photo", edit_user_dashboard_registration_path(@user), remote: true
    end
  end
end