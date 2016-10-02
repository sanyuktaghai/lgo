require 'rails_helper'

RSpec.feature "Listing Bookmarked Stories" do 
  before do
    @author = FactoryGirl.create(:user_with_published_stories, stories_count: 2)
    @user = FactoryGirl.create(:user_with_published_stories)
    @story1 = Story.where(author_id: @author.id).first
    @story2 = Story.where(author_id: @author.id).last
    @story3 = Story.find_by(author_id: @user.id)
    
    @bookmark1 = FactoryGirl.create(:bookmark)
    @bookmark2 = FactoryGirl.create(:bookmark)
    @bookmark3 = FactoryGirl.create(:bookmark)
    @bookmark1.update(user_id: @user.id, story_id: @story1.id)
    @bookmark2.update(user_id: @user.id, story_id: @story2.id)
    @bookmark3.update(user_id: @user.id, story_id: @story3.id)
    
    login_as(@user, :scope => :user)
  end
  
  scenario "Logged-in user can see the list of the stories she's bookmarked", js: true do
    visit(dashboard_path(@user))
    click_link "Saves"
    
    expect(page).to have_content(Story.where.not(author_id: @user.id).joins(:bookmarks).where(:bookmarks => {:user_id => @user.id}).count)
    expect(page).to have_content("Saves: 2")

    expect(page).to have_content(@story1.final_title)
    expect(page).to have_content(@story1.final_body.truncate(150))
    expect(page).to have_link(@story1.final_title)
    
    expect(page).to have_content(@story2.final_title)
    expect(page).to have_content(@story2.final_body.truncate(150))
    expect(page).to have_link(@story2.final_title)
    
    expect(page).not_to have_content(@story3.final_title)
    expect(page).not_to have_content(@story3.final_body.truncate(150))
    expect(page).not_to have_link(@story3.final_title)
   end
end