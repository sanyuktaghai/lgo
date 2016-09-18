require "rails_helper"

RSpec.feature "Deleting StoryLikes" do
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    
    @story_foo = Story.create(title: "The first story", body: "Body of first story", user: @foo)
    @story_bar = Story.create(title: "The second story", body: "Body of second story", user: @bar)
    @story_like = StoryLike.create(user: @foo, story: @story_bar)
  end
  
  scenario "A user succeeds" do
    login_as(@foo, :scope => :user)
    
    visit "/"
    click_link @story_bar.title  
    click_link "Unlike Story"
    
    expect(page).to have_content("Like has been deleted")
    expect(page).not_to have_content("Likes: 0")
  end
end