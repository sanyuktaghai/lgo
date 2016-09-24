require "rails_helper"

RSpec.feature "Deleting StoryLikes" do
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    
    @story_foo = Story.create(raw_title: "The first story", raw_body: "Body of first story", user: @foo)
    @story_bar = Story.create(raw_title: "The second story", raw_body: "Body of second story", user: @bar)
    @story_like = StoryLike.create(user: @foo, story: @story_bar)
  end
  
  scenario "A user succeeds", :js => true do
    login_as(@foo, :scope => :user)
    
    visit "/"
    click_link @story_bar.raw_title  
    click_link "Unlike Story"
    
    expect(page).to have_content("Like has been deleted")
    expect(page).to have_content("Likes: 0")
    expect(page).to have_button("Like Story")
    expect(page).not_to have_link("Unlike Story")
  end
end