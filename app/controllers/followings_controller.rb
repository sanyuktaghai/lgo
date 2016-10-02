class FollowingsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    unless current_user
      flash[:warning] = "Please sign in to continue"
      redirect_to new_user_session_path
    else
      follow = User.find(params[:user_id])
      Following.create(following_params.merge!(follower_id: current_user.id, user_id: params[:user_id])) if current_user.follows_or_same?(follow)
      flash[:success] = "You are now following #{follow.full_name}"
      redirect_to dashboard_path(follow.id)
    end
  end
  
  private
  
  def following_params
    params.permit(:follower_id, :user_id) 
  end
  
end