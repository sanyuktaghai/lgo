class ReactionsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @reaction = Reaction.create(reaction_params)
    if @reaction.save
      respond_to do |format|
        @story = Story.find(@reaction.story_id)
        format.js {render :data => [ @reaction.to_json, @story.to_json] }
      end
    else
      flash[:warning] = "Your reaction could not be recorded."
      redirect_to story_path(Story.find(@reaction.story_id))
    end
  end
  
  def destroy
    @reaction = Reaction.find(params[:id])
    @story = Story.find(@reaction.story_id)
    respond_to do |format|
      if @reaction.destroy
        format.js {render :data => @reaction.to_json }
      else
        flash[:danger] = "Your reaction could not be removed."
        redirect_to story_path(Story.find(@reaction.story_id))
      end
    end
  end
  
  private
  
  def reaction_params
    params.permit(:story_id, :user_id, :reaction_category_id) 
  end
end