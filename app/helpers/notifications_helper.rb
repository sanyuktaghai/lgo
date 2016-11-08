module NotificationsHelper
  def notification_text(notification)
    notifier = User.find(notification.notified_by_user_id)
    link_notifier = link_to notifier.full_name, dashboard_path(notifier)
    
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
      
      unless notification.options == "commenters"
        # Story author gets a notification
        text = link_notifier+" commented on your story, "+ link_story
      else
        # Other commenters get a notification
        text = link_notifier+" also commented on "+ link_story
      end 
      
    when 3 #Reaction
      reaction = Reaction.find(notification.origin_id)
      story = Story.find(reaction.story_id)
      link = link_to story_title(story), story_path(story)
      
      case notification.options
      when "1" #like
        text = link_notifier+" liked your story, "+link
      when "2" #omg
        text = link_notifier+" OMG'd your story, "+link
      when "3" #lol
        text = link_notifier+" LOL'd your story, "+link
      when "4" #cool
        text = link_notifier+" Cool'd your story, "+link
      else #5 - love 
        text = link_notifier+" Loved your story, "+link
      end
      
    when 4 #Bookmark
      bookmark = Bookmark.find(notification.origin_id)
      story = Story.find(bookmark.story_id)
      link = link_to story_title(story), story_path(story)
      # Story author gets a notification
      text = "Woohoo! Someone bookmarked your story, "+link
      
    else #Following
      text = link_notifier+ " followed you."
    end
      
    text
  end
end