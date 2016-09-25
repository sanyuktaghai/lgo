class Admin::StoriesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :require_admin
  
  def index
    @stories = Story.unpublished
  end
  
  private
  
  def require_admin
    unless current_user.admin?
      redirect_to root_path
      flash[:alert] = "Error."
    end
  end
end