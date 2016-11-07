module NotificationsHelper
  def notification_text(notification)
    case notification.notification_category_id
    when 1 #Story published
      story = Story.find(notification.origin_id)
      link = link_to story_title(story), story_path(story)
      text = "Your story has been published! See it here: "+link
    when 2 #Comment, notification to story author
      story = Story.find(Comment.find(notification.origin_id).story_id)
      link_story = link_to story_title(story), story_path(story)
      commenter = User.find(notification.notified_by_user_id)
      link_user = link_to commenter.full_name, dashboard_path(commenter)
      
      unless notification.options == "commenters"
        # Story author gets a notification
        text = link_user+" commented on your story, "+ link_story
      else
        # Other commenters get a notification
        text = link_user+" also commented on "+ link_story
      end 
    when 3 #Reaction
    when 4 #Bookmark
    when 5 #Following
    else #Comment, notification to story 
      follower = User.find(notification.notified_by_user_id)
      link = link_to follower.full_name, dashboard_path(follower)
      text = link+ " followed you."
    end
    text
  end
end