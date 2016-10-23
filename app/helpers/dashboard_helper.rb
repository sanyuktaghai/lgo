module DashboardHelper
  def user_photo(user)
    if @user.fbimage?
      image_tag(@user.largesquareimage)
    elsif @user.image_file_name?
      image_tag @user.image.url(:medium)
    else
      link_to "Upload Photo", edit_user_dashboard_registration_path(@user), remote: true
    end
  end
end