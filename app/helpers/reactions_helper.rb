module ReactionsHelper
  def link_to_reaction(select_text, story, reaction_category, classes)    
    unless current_user
      link_to select_text, reactions_path(user_id: 0, story_id: story.id, reaction_category_id: reaction_category), method: :post, class: "button"
    else
      if Reaction.where(story_id: @story.id, user_id: current_user.id, reaction_category_id: reaction_category).empty?
        link_to select_text, reactions_path(user_id: current_user.id, story_id: story.id, reaction_category_id: reaction_category, select_text: select_text), method: :post, class: "button", remote: true
      else
        link_to "Un"+select_text.split(/\s/).first, reaction_path(story, current_user, reaction_category_id: reaction_category), method: :delete, class: "button", remote: true      
      end
    end
  end
  
  def reaction_count_label(select_text)
    select_text.split(/\s/).first+"s: "
  end
  
  def reaction_count(select_text, story, reaction_category)
    Story.where(id: story.id).joins(:reactions).where(reactions: {reaction_category_id: reaction_category}).count
  end
end