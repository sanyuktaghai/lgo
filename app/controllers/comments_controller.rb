class CommentsController < ApplicationController
  before_action :set_story
  
  def index
    @comment = @story.comments.all
  end
  
  def create
    unless current_user
      flash[:warning] = "Please sign in to continue"
      redirect_to new_user_session_path
    else
      @comment = @story.comments.build(comment_params)
      @comment.user = current_user
      
      respond_to do |format|
        if @comment.save
          flash[:success] = "Comment has been added"
          format.html { redirect_to story_path(@story) }
        else
          flash[:warning] = "Comment has not been added"
#          format.html {render :new}
          format.js
#          render "stories/show"
        end
#       redirect_to story_path(@story)
      end
    end
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
  def set_story
    @story = Story.find(params[:story_id])#if just :id, it's comment id
  end
end
