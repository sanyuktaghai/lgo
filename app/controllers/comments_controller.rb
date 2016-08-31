class CommentsController < ApplicationController
  before_action :set_story
  
  def create
    @comment = @story.comments.build(comment_params)
    @comment.user = current_user
    
    if @comment.save
      flash[:success] = "Comment has been added"
    else
      flash.now[:danger] = "Comment has not been added"
    end
    redirect_to story_path(@story)
  end
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
  def set_story
    @story = Story.find(params[:story_id])#if just :id, it's comment id
  end
end
