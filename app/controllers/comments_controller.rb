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
          format.js
        end
      end
    end
  end
  
  def edit
    @comment = @story.comments.find(params[:id])
    
    if @comment.user != current_user
      flash[:alert] = "You can only edit your own comments"
      redirect_to story_path(@story)
    end   
  end
  
  def update
    @comment = @story.comments.find(params[:id])
    if @comment.user != current_user
      flash[:alert] = "You can only edit your own comments"
      redirect_to story_path(@story)
    else
      respond_to do |format|
        if @comment.update(comment_params)
          flash[:success] = "Comment has been updated"
          format.html {redirect_to story_path(@story)}
        else
          flash.now[:alert] = "Comment has not been updated"
          format.js
        end
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
