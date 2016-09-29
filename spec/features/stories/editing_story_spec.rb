require 'rails_helper'

RSpec.feature "Editing Stories" do 
  before do
    @user = FactoryGirl.create(:user_with_published_stories)
    login_as(@user, :scope => :user)
    @story = Story.find_by(author_id: @user.id)
    @updated_title = Faker::Hipster::sentence
    @updated_body = Faker::Hipster::paragraph
  end
  
  scenario "A user edits a story" do
    visit "/"
    
    click_link @story.final_title
    click_link "Edit Story"
    
    fill_in "Title", with: @updated_title
    fill_in "Body", with: @updated_body
    click_button "Update Story"
    
    expect(page).to have_content("Story has been updated")
    expect(page.current_path).to eq(stories_path)   
  end
  
  scenario "A user fails to edit a story" do
    visit "/"
    
    click_link @story.final_title
    click_link "Edit Story"
    
    fill_in "Title", with: ""
    fill_in "Body", with: @updated_body
    click_button "Update Story"
    
    expect(page).to have_content("Story has not been updated")
    expect(page.current_path).to eq(story_path(@story))
  end
end