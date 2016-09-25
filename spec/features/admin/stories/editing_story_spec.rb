require 'rails_helper'

RSpec.feature "Editing Stories" do 
  before do
    @user = FactoryGirl.create(:user_with_stories)
    @user2 = FactoryGirl.create(:user_with_unpublished_updated_stories)
    @admin = FactoryGirl.create(:admin)
    @story = Story.find_by(user_id: @user.id)
    @story2 = Story.find_by(user_id: @user2.id)
    
  end
  
  scenario "An admin edits a story" do
    login_as(@admin, :scope => :user)
    visit "/admin"
    
    click_link @story.raw_title
    click_link "Edit Story"
    
    expect(page).to have_content(@story.user(:author_id).email)
    expect(page).to have_content(@story.created_at.strftime("%b %d, %Y"))
    expect(page).to have_content(@story.raw_title)
    expect(page).to have_content(@story.raw_body)
    
    fill_in "Final Title", with: "Final Story Title"
    fill_in "Final Body", with: "Final story body"
    check 'Published'
    click_button "Update Story"
    
    expect(page).to have_content("Story has been updated")
    expect(page.current_path).to eq(admin_story_path(@story))  
    expect(page).to have_content(@story.final_title)
    expect(page).to have_content(@story.final_body)
    expect(page).to have_content(@story.user(:admin_id).email)
  end
  
  scenario "An admin edits an updated story" do
    login_as(@admin, :scope => :user)
    visit "/admin"
    
    click_link @story2.raw_title
    click_link "Edit Story"
    
    expect(page).to have_content(@story2.updated_title)
    expect(page).to have_content(@story2.updated_body)
    
    fill_in "Final Title", with: "Final Story Title"
    fill_in "Final Body", with: "Final story body"
    check 'Published'
    click_button "Update Story"
    
    expect(page).to have_content("Story has been updated")
    expect(page.current_path).to eq(admin_story_path(@story2))  
    expect(page).to have_content("Final Story Title")
    expect(page).to have_content("Final story body")
  end
end