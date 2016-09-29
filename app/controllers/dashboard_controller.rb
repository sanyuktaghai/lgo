class DashboardController < ApplicationController
  before_action :set_user, only: [:show, :liked_stories, :authored_stories]
  
  def show
    @stories = Story.all
    @authored_stories = @stories.where(author_id: @user)
  end
  
  def liked_stories
    @liked_stories = Story.where.not(author_id: @user.id).joins(:story_likes).where(:story_likes => { :user_id => @user.id})
    respond_to do |format|
      format.js {render :partial => 'dashboard/liked_stories'} 
    end
  end
  
  def authored_stories
    @authored_stories = Story.where(author_id: @user)
    respond_to do |format|
      format.js {render :partial => 'dashboard/authored_stories'} 
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
