module DashboardHelper
  def user_photo(user)
    if @user.image?
      image_tag(@user.largesquareimage)
    end
  end
end