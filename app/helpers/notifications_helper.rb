module NotificationsHelper
  def notification_text(notification)
    case notification.notification_category_id
      
    when 1 #Story
      story = Story.find(notification.origin_id)
      link = link_to story_title(story), story_path(story)
      unless notification.options == "followers"
        # Story author gets a notification
        text = "Your story has been published! See it here: "+link
      else
        poster = User.find(story.poster_id)
        link_poster = link_to poster.full_name, dashboard_path(poster)
        # Poster followers get a notification
        text = link_poster+" published a new story! See it here: "+link
      end
        
    when 2 #Comment
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
      bookmark = Bookmark.find(notification.origin_id)
      story = Story.find(bookmark.story_id)
      link = link_to story_title(story), story_path(story)
      # Story author gets a notification
      text = "Woohoo! Someone bookmarked your story, "+link
      
    else #Following
      follower = User.find(notification.notified_by_user_id)
      link = link_to follower.full_name, dashboard_path(follower)
      text = link+ " followed you."
    end
      
    text
  end
end