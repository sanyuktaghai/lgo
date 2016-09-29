class DashboardController < ApplicationController
  before_action :set_user, only: [:show, :liked_stories, :authored_stories, :bookmarked_stories, :commented_stories]
  
  before_action :set_authored_stories, only: [:show, :authored_stories]  
  before_action :set_liked_stories, only: [:show, :liked_stories]  
  before_action :set_bookmarked_stories, only: [:show, :bookmarked_stories]
  before_action :set_commented_stories, only: [:show, :commented_stories]
  
  def show
  end
  
  def liked_stories
    respond_to do |format|
      format.js {render :partial => 'dashboard/liked_stories'} 
    end
  end
  
  def authored_stories
    respond_to do |format|
      format.js {render :partial => 'dashboard/authored_stories'} 
    end
  end
  
  def bookmarked_stories
    respond_to do |format|
      format.js {render :partial => 'dashboard/bookmarked_stories'} 
    end
  end
  
  def commented_stories
    respond_to do |format|
      format.js {render :partial => 'dashboard/commented_stories'} 
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def set_authored_stories
    @authored_stories = Story.where(author_id: @user)
  end
  
  def set_liked_stories
    @liked_stories = Story.where.not(author_id: @user.id).joins(:story_likes).where(:story_likes => { :user_id => @user.id})
  end
  
  def set_bookmarked_stories
    @bookmarked_stories = Story.where.not(author_id: @user.id).joins(:bookmarks).where(:bookmarks => { :user_id => @user.id})
  end
  
  def set_commented_stories
    @commented_stories = Story.where.not(author_id: @user.id).joins(:comments).where(:comments => { :user_id => @user.id})
  end
end