require "rails_helper"

RSpec.feature "Adding Saves to Stories" do
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    
    @story = Story.create(title: "The first story", body: "Body of first story", user: @foo)
  end
  
  scenario "Permit a signed in user to save a story", :js => true do
    login_as(@bar, :scope => :user)
    
    visit "/"
    click_link @story.title
  
    click_button "Save Story"
    
    expect(page).to have_content("Saves: 1")
    expect(page.current_path).to eq(story_path(@story))
  end
  
  scenario "A non-signed in user fails to save a story", :js => true do
    visit "/"
    click_link @story.title
    
    click_button "Save Story"
    
    expect(page).to have_content("Please sign in to continue")
    expect(page.current_path).to eq(new_user_session_path)
  end
end