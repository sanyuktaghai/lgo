class StoryLikesController < ApplicationController
  before_action :set_story
#  before_action :find_likes
  
  def create
    unless current_user
      flash[:warning] = "Please sign in to continue"
      redirect_to new_user_session_path
    else
      @story_like = @story.story_likes.build(story_likes_params)
      @story_like.user = current_user
      if @story_like.save
        flash[:success] = "Like has been added"
      else
        flash[:warning] = "Like has not been added"
      end
      redirect_to story_path(@story)
    end
  end
  
  def destroy
    @story_like = @story.story_likes.find_by(user_id: current_user)
    if @story_like.destroy
      flash[:success] = "Like has been deleted"
      redirect_to story_path(@story)
    end
  end
  
  private
  
  def story_likes_params
#    params.require(:story_like).permit(:user_id, :story_id) #Q:Do i need to whitelist this? It throws an error.
  end
  
  def set_story
    @story = Story.find(params[:story_id])
  end
  
  def find_likes
#    @user = current_user
#    @story_like = @story.story_likes.find(params[:user_id])
  end
end