class FollowingsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    unless current_user
      flash[:warning] = "Please sign in to continue"
      redirect_to new_user_session_path
    else 
      @following = Following.create(following_params)
      if @following.save
        respond_to do |format|
          @user = User.find(@following.user_id)
#          @test = @following.id
          flash.now[:success] = "You are now following #{@user.full_name}"
          format.js
        end
#        format.html {redirect_to root_path}
      else
        flash[:warning] = "#{@following.user.full_name} could not be followed"
        redirect_to dashboard_path(@user)
      end
    end
  end
  
  def destroy
    @following = Following.where(following_params).first
    if @following.destroy
      respond_to do |format|
        @test = @following.id
        @user = User.find(@following.user_id)
        flash.now[:success] = "You unfollowed #{@user.full_name}"
        format.js
      end
#      redirect_to dashboard_path(@user)
    else
      flash[:danger] = "#{@following.user.full_name} could not be unfollowed"
      redirect_to dashboard_path(@user)
    end
  end
  
  private
  
  def following_params
    params.permit(:follower_id, :user_id) 
  end
  
end