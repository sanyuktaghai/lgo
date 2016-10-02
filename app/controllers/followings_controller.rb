class FollowingsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    unless current_user
      flash[:warning] = "Please sign in to continue"
      redirect_to new_user_session_path
    else
      follower = User.find(params[:follower_id])
      Following.create(following_params.merge!(follower_id: params[:follower_id], user_id: current_user.id)) unless current_user.follows_or_same?(follower)
      
      redirect_to root_path
    end
  end
  
  private
  
  def following_params
    params.permit(:follower_id, :user_id) 
  end
  
end