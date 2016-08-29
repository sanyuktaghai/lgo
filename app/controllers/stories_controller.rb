class StoriesController < ApplicationController
  def index
  end
  
  def new
    @story = Story.new
  end
  
  def create
    @story = Story.new(article_params)#uses title & body from form
    if @story.save
      flash[:success] = "Story has been submitted"
      redirect_to stories_path
    else
      flash.now[:danger] = "Story has not been submitted"
      render :new #renders the new template again
    end
  end
  
  private
  def article_params
    params.require(:story).permit(:title, :body)
  end
end
