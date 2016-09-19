require "rails_helper"

RSpec.feature "Deleting Comments" do
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    
    @story_foo = Story.create(title: "The first story", body: "Body of first story", user: @foo)
    @story_bar = Story.create(title: "The second story", body: "Body of second story", user: @bar)
    @comment1 = Comment.create(body: "Great story!", user: @foo, story: @story_foo)
    @comment2 = Comment.create(body: "Really great story!", user: @bar, story: @story_foo)
    @comment3 = Comment.create(body: "Super great story!", user: @bar, story: @story_bar)
  end
  
  scenario "An owner succeeds " do
    login_as(@foo, :scope => :user)
    
    visit "/"
    click_link @story_foo.title  
    click_link "Delete"
    
    expect(page).to have_content("Comment has been deleted")
    expect(page).not_to have_content("Great story!")
  end
  
  scenario "A non-owner fails" do
    login_as(@foo, :scope => :user)

    visit "/"
    click_link @story_bar.title
    
    expect(page).not_to have_content("Delete")
    
  end
end