class StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  
  def index
    @stories = Story.published
  end
  
  def new
    @story = Story.new
  end
  
  def create
    @story = current_user.stories.build(story_params)
    @story.published = false
    @story.author_id = current_user[:id]
    respond_to do |format|
      if @story.save
        flash[:success] = "Story has been submitted"
        format.html {redirect_to stories_path}
      else
        flash.now[:alert] = "Story has not been submitted"
        format.html {render :new}
        format.js {render :partial => 'stories/storyerrors', :data => @story.to_json }
    
      end
    end
  end
  
  def show
    @comment = @story.comments.build
    @story_like = @story.story_likes.build
    @bookmark = @story.bookmarks.build
  end
  
  def edit
    if @story.user != current_user
      flash[:warning] = "You can only edit your own stories."
      redirect_to root_path
    end
  end
  
  def update
    @story.published = false
    @story.validate_updated_fields = true
    respond_to do |format|
      if @story.user != current_user
        flash[:warning] = "You can only edit your own stories."
        redirect_to root_path
      else
        if @story.update(story_params)
          flash[:success] = "Story has been updated"
          format.html {redirect_to stories_path}
        else
          flash.now[:alert] = "Story has not been updated"
          format.html {render :edit} #renders edit tmplt again
          format.js {render :partial => 'stories/storyerrors', :data => @story.to_json }
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
    params.require(:story).permit(:raw_title, :raw_body, :updated_title, :updated_body)
  end
  
  def set_story
    @story = Story.find(params[:id])
    #to make sure users can only get to their own stories
    #@story = current_user.stories.find(params[:id]) #This first grabs the user, then grabs their stories, starts with a smaller scope than all stories
  end
end