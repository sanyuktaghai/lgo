class PicturesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  
  def edit
  end
  
  def destroy
    @picture = Picture.find(params[:id])
    @story = Story.find(@picture.story_id)
    if @picture.destroy
      redirect_to story_path(@story)
    end
  end
  
end