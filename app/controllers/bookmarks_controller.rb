class BookmarksController < ApplicationController
  before_action :set_story
  
  def create
    unless current_user
      flash[:warning] = "Please sign in to continue"
      redirect_to new_user_session_path
    else
      @bookmark = @story.bookmarks.build(bookmarks_params)
      @bookmark.user = current_user
      respond_to do |format|
        if @bookmark.save
          flash.now[:success] = "Save has been added"
          format.js {render :partial => 'bookmarks/showbookmarks'}
          format.html {redirect_to story_path(@story)}
        else
          flash[:warning] = "Save has not been added"
          format.html { redirect_to story_path(@story)}
        end
      end
    end
  end
  
  def destroy
    @bookmark = @story.bookmarks.find_by(user_id: current_user)
    respond_to do |format|
      if @story_like.destroy
        flash.now[:success] = "Like has been deleted"
        format.js {render :partial => 'bookmarks/showbookmarks'}
        redirect_to story_path(@story)
      end
    end
  end
  
  private
  
  def bookmarks_params
#    params.require(:story_like).permit(:user_id, :story_id) #Q:Do i need to whitelist this? It throws an error.
  end
  
  def set_story
    @story = Story.find(params[:story_id])
  end
end