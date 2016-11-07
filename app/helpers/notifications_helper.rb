module NotificationsHelper
  def notification_text(notification)
    case notification.notification_category_id
    when 1 #Story published
      story = Story.find(notification.origin_id)
      link = link_to story_title(story), story_path(story)
      text = "Your story has been published! See it here: "+link
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