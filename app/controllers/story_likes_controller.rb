class StoryLikesController < ApplicationController
  before_action :set_story
  
  def create
    unless current_user
      flash[:warning] = "Please sign in to continue"
      redirect_to new_user_session_path
    else
      @story_like = @story.story_likes.build(story_likes_params)
      @story_like.user = current_user
      respond_to do |format|
        if @story_like.save
          flash.now[:success] = "Like has been added"
          format.js {render :partial => 'story_likes/showstorylikes'}
        else
          flash[:warning] = "Like has not been added"
          format.html { redirect_to story_path(@story)}
        end
      end
    end
  end
  
  def destroy
    @story_like = @story.story_likes.find_by(user_id: current_user)
    respond_to do |format|
      if @story_like.destroy
        flash.now[:success] = "Like has been deleted"
        format.js {render :partial => 'story_likes/showstorylikes'}
#        redirect_to story_path(@story)
      end
    end
  end
  
  private
  
  def story_likes_params
#    params.require(:story_like).permit(:user_id, :story_id) #Q:Do i need to whitelist this? It throws an error.
  end
  
  def set_story
    @story = Story.find(params[:story_id])
  end
end