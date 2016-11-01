module StoriesHelper
  def story_main_image_show(story)
    if story.main_image?
<<<<<<< HEAD
      image_tag story.main_image.url
    else
=======
      story.main_image.url
>>>>>>> parent of 895f910... fix bug on stories show page s.t. ignores stories with blank main_image
    end
  end
  
  def story_title_show(story)
    if story.published?
      story.final_title
    else
      unless story.final_title? #story only has raw title
        story.raw_title
      else #story has final title and maybe also updated title
        datearray = [story.updated_at.to_i, story.admin_updated_at.to_i]
        if datearray.max == story.admin_updated_at.to_i #max => most recent
          story.final_title
        else 
          story.updated_title
        end
      end
    end
  end
  
  def story_body_show(story)
    if story.published?
      body = story.final_body
    else
      unless story.final_body? #story only has raw body
        body = story.raw_body
      else #story has final body and maybe also updated body
        datearray = [story.updated_at.to_i, story.admin_updated_at.to_i]
        if datearray.max == story.admin_updated_at.to_i #max => most recent
          body = story.final_body
        else 
          body = story.updated_body
        end
      end
    end
    html = "<div>#{body}</div>".html_safe
  end
  
  def story_by_show(story)
    if story.published?
      link = link_to "#{User.find(story.poster_id).full_name}", dashboard_path(User.find(story.poster_id))
      partial =  render partial: 'followings/form', locals: { user: User.find(story.poster_id), follower: current_user }
      html = "<div>Posted by: #{link}</div><div>#{partial}</div>".html_safe
     
    else
      if story.anonymous?
        html = "<div>Posted by: Anonymous</div>"
      else
        link = link_to "#{User.find(story.author_id).full_name}", dashboard_path(User.find(story.author_id))
        html = "<div>Posted by: #{link}".html_safe
      end
    end
  end
  
  def truncate_body_list(body)
    body.gsub!('<br>', ' ')
    truncate(strip_tags("#{body}").gsub('&amp;','&'), length: 150)
  end
end