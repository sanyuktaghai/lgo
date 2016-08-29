class StoriesController < ApplicationController
  def index
    @stories = Story.all
  end
  
  def new
    @story = Story.new
  end
  
  def create
    @story = Story.new(story_params)#uses title & body from form
    if @story.save
      flash[:success] = "Story has been submitted"
      redirect_to stories_path
    else
      flash.now[:danger] = "Story has not been submitted"
      render :new #renders the new template again
    end
  end
  
  def show
    @story = Story.find(params[:id])
  end
  
  def edit
    @story = Story.find(params[:id])
  end
  
  def update
    @story = Story.find(params[:id])
    if @story.update(story_params)
      flash[:success] = "Story has been updated"
      redirect_to @story
    else
      flash.now[:danger] = "Story has not been updated"
      render :edit #renders the edit template again
    end
  end
  
  private
  def story_params
    params.require(:story).permit(:title, :body)
  end
end
