class ReactionsController < ApplicationController
  before_action :authenticate_user!
  
  def create
#    unless current_user
#      flash[:warning] = "Please sign in to continue"
#      redirect_to new_user_session_path
#    else 
    @reaction = Reaction.create(reaction_params)
#    @select_text = @reaction.select_text
    if @reaction.save
      respond_to do |format|
        flash[:success] = "You Lol'd the story"
        format.js {render :data => @reaction.to_json }
#        format.js {render "create", :locals => {:select_text => @select_text}}
#        format.html { redirect_to story_path(Story.find(@reaction.story_id)) }
      end
    else
      flash[:warning] = "Your reaction could not be recorded."
      redirect_to story_path(Story.find(@reaction.story_id))
#      end
    end
  end
  
  def destroy
    @reaction = Reaction.where(reaction_params).first
    @story_id = @reaction.story_id
#    binding.pry
    if @reaction.destroy
      respond_to do |format|
        flash.now[:success] = "You UnLol'd the story"
        format.js
      end
    else
      flash[:danger] = "Your reaction could not be removed."
      redirect_to story_path(Story.find(@reaction.story_id))
    end
  end
  
  private
  
  def reaction_params
    params.permit(:story_id, :user_id, :reaction_category_id) 
  end
end