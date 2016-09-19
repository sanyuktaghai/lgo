require "rails_helper"

RSpec.feature "Deleting Bookmarks" do
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    
    @story_foo = Story.create(title: "The first story", body: "Body of first story", user: @foo)
    @story_bar = Story.create(title: "The second story", body: "Body of second story", user: @bar)
    @bookmark = Bookmark.create(user: @foo, story: @story_bar)
  end
  
  scenario "A user succeeds", :js => true do
    login_as(@foo, :scope => :user)
    
    visit "/"
    click_link @story_bar.title  
    click_link "Unsave Story"
    
    expect(page).to have_content("Story save has been deleted")
    expect(page).to have_content("Saves: 0")
    expect(page).to have_button("Save Story")
    expect(page).not_to have_link("Unsave Story")
  end
end