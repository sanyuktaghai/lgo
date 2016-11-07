module NotificationsHelper
  def notification_text(notification)
    case notification.notification_category_id
    when 1 #Story published
    when 2 #Comment
    when 3 #Reaction
    when 4 #Bookmark
    else #Following
      follower = User.find(notification.notified_by_user_id)
      link = link_to follower.full_name, dashboard_path(follower)
      text = link+ " followed you."
    end
    text
  end
end