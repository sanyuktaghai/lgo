require 'rails_helper'

RSpec.feature "Listing Stories" do 
  before do
    @author = FactoryGirl.create(:user_with_published_stories, stories_count: 2)
    @user = FactoryGirl.create(:user_with_published_stories)
    @story1 = Story.where(author_id: @author.id).first
    @story2 = Story.where(author_id: @author.id).last
    @story3 = Story.find_by(author_id: @user.id)
    
    @story_like1 = FactoryGirl.create(:story_like)
    @story_like2 = FactoryGirl.create(:story_like)
    @story_like3 = FactoryGirl.create(:story_like)
    @story_like1.update(user_id: @user.id, story_id: @story1.id)
    @story_like2.update(user_id: @user.id, story_id: @story2.id)
    @story_like3.update(user_id: @user.id, story_id: @story3.id)
    
    login_as(@user, :scope => :user)
  end
  
  scenario "Logged-in user can see the list of the stories she's liked", js: true do
    visit(dashboard_path(@user))
    click_link "Likes"
    
    expect(page).to have_content(Story.where.not(author_id: @user.id).joins(:story_likes).where(:story_likes => {:user_id => @user.id}).count)
    expect(page).to have_content("2 Likes")

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