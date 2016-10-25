module DashboardHelper
  def user_photo(user)
    if @user == current_user
      if @user.image_file_name?
        image_tag @user.image.url(:medium)
      elsif @user.fbimage?
        image_tag(@user.largesquareimage)
      else
        link_to "Upload Photo", edit_user_dashboard_registration_path(@user), remote: true
        end
    end
  end
  
  def story_title(story)
    if story.published?
      link_to story.final_title, story_path(story)
    else
      unless story.final_title? #story only has raw title
        link_to story.raw_title, story_path(story)
      else #story has final title and maybe also updated title
        datearray = [story.updated_at, story.admin_updated_at]
        if datearray.max == story.admin_updated_at #max => most recent
          link_to story.final_title, story_path(story)
        else 
          link_to story.updated_title, story_path(story)
        end
      end
    end
  end
  
  def story_body(story)
    if story.published?
      body = story.final_body
    else
      unless story.final_body? #story only has raw body
        body = story.raw_body
      else #story has final body and maybe also updated body
        datearray = [story.updated_at, story.admin_updated_at]
        if datearray.max == story.admin_updated_at #max => most recent
          body = story.final_body
        else 
          body = story.updated_body
        end
      end
    end
    truncate(strip_tags(body).gsub('&amp;','&'), length: 150)
  end
  
  def story_pending(story)
    unless story.published?
      html = "<div>Pending</div>".html_safe
    end
  end
  
  def story_anonymous(story)
    if story.anonymous?
      html = "<div>Anonymous</div>".html_safe
    end
  end
  
  def story_by(story)
    if story.poster_id?
      html = "<div>Posted by: #{User.find(story.poster_id).full_name}</div>".html_safe
    else
      html = "<div>Written by: #{User.find(story.author_id).full_name}</div>".html_safe
    end
  end
end