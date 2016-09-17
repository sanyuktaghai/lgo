require "rails_helper"

RSpec.feature "Adding Likes to Stories" do
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    
    @story = Story.create(title: "The first story", body: "Body of first story", user: @foo)
  end
  
  scenario "Permit a signed in user to like a story" do
    login_as(@bar, :scope => :user)
    
    visit "/"
    click_link @story.title
  
    click_button "Like Story"
    
    expect(page).to have_content("Likes: 1")
    expect(page.current_path).to eq(story_path(@story))
  end
end

