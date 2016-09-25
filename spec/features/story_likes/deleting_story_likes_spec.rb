require "rails_helper"

RSpec.feature "Deleting StoryLikes" do
  before do
    @bar = FactoryGirl.create(:user_with_published_stories)
    @foo = FactoryGirl.create(:user_with_published_stories)
    @story_foo = Story.find_by(user_id: @foo.id)
    @story_bar = Story.find_by(user_id: @bar.id)
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