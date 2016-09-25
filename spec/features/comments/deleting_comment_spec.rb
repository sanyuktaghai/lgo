require "rails_helper"

RSpec.feature "Deleting Comments" do
  before do
    @bar = FactoryGirl.create(:user_with_published_stories)
    @foo = FactoryGirl.create(:user_with_published_stories)
    @story_foo = Story.find_by(user_id: @foo.id)
    @story_bar = Story.find_by(user_id: @bar.id)
    
    @comment1 = Comment.create(body: "Great story!", user: @foo, story: @story_foo)
    @comment2 = Comment.create(body: "Really great story!", user: @bar, story: @story_foo)
    @comment3 = Comment.create(body: "Super great story!", user: @bar, story: @story_bar)
  end
  
  scenario "An owner succeeds " do
    login_as(@foo, :scope => :user)
    
    visit "/"
    click_link @story_foo.raw_title  
    click_link "Delete"
    
    expect(page).to have_content("Comment has been deleted")
    expect(page).not_to have_content("Great story!")
  end
  
  scenario "A non-owner fails" do
    login_as(@foo, :scope => :user)

    visit "/"
    click_link @story_bar.raw_title
    
    expect(page).not_to have_content("Delete")
    
  end
end