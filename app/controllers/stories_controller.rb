class StoriesController < ApplicationController
  def index
  end
  
  def new
    @story = Story.new
  end
  
  def create
    @story = Story.new(article_params)#uses title & body from form
    @story.save
    flash[:success] = "Story has been submitted"
    redirect_to stories_path
  end
  
  private
  def article_params
    params.require(:story).permit(:title, :body)
  end
end
