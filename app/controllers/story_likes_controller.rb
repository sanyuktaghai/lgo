class StoryLikesController < ApplicationController
  before_action :set_story
  
  def create
    @story_like = @story.story_likes.build(story_likes_params)
    @story_like.user = current_user
    if @story_like.save
      flash[:success] = "Like has been added"
    else
      flash[:warning] = "Like has not been added"
    end
    redirect_to story_path(@story)
  end
  
  private
  
  def story_likes_params
    #    params.require(:story_like).permit(:id) #Q:Do i need to whitelist this? It throws an error.
  end
  
  def set_story
    @story = Story.find(params[:story_id])
  end
end