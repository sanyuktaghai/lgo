require "rails_helper"

RSpec.feature "Deleting Bookmarks" do
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    
    @story_foo = Story.create(raw_title: "The first story", raw_body: "Body of first story", user: @foo)
    @story_bar = Story.create(raw_title: "The second story", raw_body: "Body of second story", user: @bar)
    @bookmark = Bookmark.create(user: @foo, story: @story_bar)
  end
  
  scenario "A user succeeds", :js => true do
    login_as(@foo, :scope => :user)
    
    visit "/"
    click_link @story_bar.raw_title  
    click_link "Unsave Story"
    
    expect(page).to have_content("Story save has been deleted")
    expect(page).to have_content("Saves: 0")
    expect(page).to have_button("Save Story")
    expect(page).not_to have_link("Unsave Story")
  end
end