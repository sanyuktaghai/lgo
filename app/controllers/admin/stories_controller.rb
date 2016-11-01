class Admin::StoriesController < ApplicationController
#  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_admin
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  
  def index
    @stories = Story.unpublished
  end
  
  def show
  end
  
  def edit
  end
  
  def destroy
    if @story.destroy
      flash[:success] = "Story has been deleted"
      redirect_to admin_stories_path
    end
  end
  
  def update
    @story.validate_final_fields = true
    @story.validate_main_image = true
    @story.admin_id = current_user[:id]
    @story.admin_updated_at = DateTime.current
    unless @story.anonymous?
      @story.poster_id = @story.author_id
    else
      @story.poster_id = 3
    end
    respond_to do |format|
      if @story.update(story_params)
        flash[:success] = "Story has been updated"
        format.html {redirect_to admin_story_path(@story)}
      else
        flash.now[:alert] = "Story has not been updated"
        format.html {render :edit}
        format.js {render :partial => 'admin/stories/storyerrors', :data => @story.to_json }
      end
    end
  end
  
  private
  def story_params
    params.require(:story).permit(:final_title, :final_body, :published, :admin_updated_at, :main_image)
  end
  
  def require_admin
    unless current_user.admin?
      redirect_to root_path
      flash[:alert] = "Error."
    end
  end
  
  def set_story
    @story = Story.find(params[:id])
  end
end