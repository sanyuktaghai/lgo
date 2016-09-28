class DashboardController < ApplicationController
  def show
    @user = User.find(params[:id])
    @stories = Story.where(author_id: @user)
  end
end
