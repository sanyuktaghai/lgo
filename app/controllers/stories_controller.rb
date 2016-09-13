class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  
  def index
    @stories = Story.all
  end
  
  def new
    @story = Story.new
  end
  
  def create
    @story = current_user.stories.build(story_params)
    respond_to do |format|
      if @story.save
        flash[:success] = "Story has been submitted"
        format.html {redirect_to stories_path}
        format.js
      else
        flash.now[:alert] = "Story has not been submitted"
        format.html {render :new}
        format.js
      end
    end
  end
  
  def show
    @comment = @story.comments.build
  end
  
  def edit
    if @story.user != current_user
      flash[:warning] = "You can only edit your own stories."
      redirect_to root_path
    end
  end
  
  def update
    respond_to do |format|
      if @story.user != current_user
        flash[:warning] = "You can only edit your own stories."
        redirect_to root_path
      else
        if @story.update(story_params)
          flash[:success] = "Story has been updated"
          format.html {redirect_to @story}
          format.js
#          redirect_to @story
        else
          flash.now[:alert] = "Story has not been updated"
          format.html {render :edit} #renders the edit template again
          format.js
        end
      end
    end
  end
  
  
  def destroy
    if @story.destroy
      flash[:success] = "Story has been deleted"
      redirect_to stories_path
    end
  end
  
  private
  def story_params
    params.require(:story).permit(:title, :body)
  end
  
  def set_story
    @story = Story.find(params[:id])
  end
end