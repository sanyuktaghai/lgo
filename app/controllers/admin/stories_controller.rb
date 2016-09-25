class Admin::StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_admin
  before_action :set_story, only: [:show, :edit, :update, :destroy]
  
  def index
    @stories = Story.unpublished
  end
  
  def show
  end
  
  def edit
  end
  
  private
  
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