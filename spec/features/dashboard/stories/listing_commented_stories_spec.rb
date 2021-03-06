require 'rails_helper'

RSpec.feature "Listing Commented Stories" do 
  before do
    @author = FactoryGirl.create(:user_with_published_stories, stories_count: 3)
    @user = FactoryGirl.create(:user_with_published_stories)
    @story1 = Story.where(author_id: @author.id).first
    @story2 = Story.where(author_id: @author.id).second
    @story3 = Story.where(author_id: @author.id).last
    @story4 = Story.find_by(author_id: @user.id)
    
    @comment1 = Comment.create(user_id: @user.id, story_id: @story1.id, body: Faker::Hipster.sentence)
    @comment2 = Comment.create(user_id: @user.id, story_id: @story2.id, body: Faker::Hipster.sentence)
    @comment3 = Comment.create(user_id: @author.id, story_id: @story3.id, body: Faker::Hipster.sentence)
    @comment4 = Comment.create(user_id: @user.id, story_id: @story4.id, body: Faker::Hipster.sentence)
    
    login_as(@user, :scope => :user)
  end
  
  scenario "Logged-in user can see the list of the stories where she's commented", js: true do
    visit(dashboard_path(@user))
    click_link "Comments"
    
    expect(page).to have_content("Comments: 3")

    expect(page).to have_content(@story1.final_title)
    expect(page).to have_content(@story1.final_body.truncate(150))
    expect(page).to have_link(@story1.final_title)
    expect(page).to have_content(@comment1.body.truncate(100))
    
    expect(page).to have_content(@story2.final_title)
    expect(page).to have_content(@story2.final_body.truncate(150))
    expect(page).to have_link(@story2.final_title)
    expect(page).to have_content(@comment2.body.truncate(100))
    
    expect(page).not_to have_content(@story3.final_title)
    expect(page).not_to have_content(@story3.final_body.truncate(150))
    expect(page).not_to have_link(@story3.final_title)
    
    expect(page).to have_content(@story4.final_title)
    expect(page).to have_content(@story4.final_body.truncate(150))
    expect(page).to have_link(@story4.final_title)
    
    expect(page).to have_css("img[src*='mainimage.png']", count: 3)
   end
end