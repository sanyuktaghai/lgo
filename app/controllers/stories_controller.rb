class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_filter :set_story, only: [:show, :edit, :update, :destroy]
  
  def index
    @stories = Story.all
  end
  
  def new
    @story = Story.new
  end
  
  def create
    @story = current_user.stories.build(story_params)
    #    @story = Story.new(story_params)#uses title & body from form #old version, use top one
    if @story.save
      flash[:success] = "Story has been submitted"
      redirect_to stories_path
    else
      flash.now[:danger] = "Story has not been submitted"
      render :new #renders the new template again
    end
  end
  
  def show
    @comment = @story.comments.build
  end
  
  def edit
    if @story.user != current_user
      flash[:danger] = "You can only edit your own stories."
      redirect_to root_path
    end
  end
  
  def update
    if @story.user != current_user
      flash[:danger] = "You can only edit your own stories."
      redirect_to root_path
    else
      if @story.update(story_params)
        flash[:success] = "Story has been updated"
        redirect_to @story
      else
        flash.now[:danger] = "Story has not been updated"
        render :edit #renders the edit template again
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