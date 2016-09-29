class DashboardController < ApplicationController
  before_action :set_user, only: [:show, :liked_stories, :authored_stories, :bookmarked_stories, :commented_stories]
  
  def show
    @stories = Story.all
    @authored_stories = @stories.where(author_id: @user)
    @liked_stories = Story.where.not(author_id: @user.id).joins(:story_likes).where(:story_likes => { :user_id => @user.id})
    @bookmarked_stories = Story.where.not(author_id: @user.id).joins(:bookmarks).where(:bookmarks => { :user_id => @user.id})
    @commented_stories = Story.where.not(author_id: @user.id).joins(:comments).where(:comments => { :user_id => @user.id})
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
  
  def bookmarked_stories
    @bookmarked_stories = Story.where.not(author_id: @user.id).joins(:bookmarks).where(:bookmarks => { :user_id => @user.id})
    respond_to do |format|
      format.js {render :partial => 'dashboard/bookmarked_stories'} 
    end
  end
  
  def commented_stories
    @commented_stories = Story.where.not(author_id: @user.id).joins(:comments).where(:comments => { :user_id => @user.id})
    respond_to do |format|
      format.js {render :partial => 'dashboard/commented_stories'} 
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
end
