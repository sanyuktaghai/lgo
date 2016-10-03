class FollowingsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    unless current_user
      flash[:warning] = "Please sign in to continue"
      redirect_to new_user_session_path
    else 
      @following = Following.create(following_params)
      @user = User.find(@following.user_id)
      flash[:success] = "You are now following #{@user.full_name}"
      redirect_to dashboard_path(@user)
    end
  end
  
  def destroy
    @following = Following.where(following_params).first
    @user = User.find(@following.user_id)
    if @following.destroy
      flash[:success] = "You unfollowed #{@user.full_name}"
      redirect_to dashboard_path(@user)
    else
      flash[:danger] = "{@following.user.full_name} could not be unfollowed"
      redirect_to dashboard_path(@user)
    end
  end
  
  private
  
  def following_params
    params.permit(:follower_id, :user_id) 
  end
  
end