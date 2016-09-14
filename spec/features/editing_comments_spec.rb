require "rails_helper"

RSpec.feature "Editing Comments" do
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
    
#    expect(page).to have_link("Edit")#need to update this to reflect a[href]
    
    link = "a[href='/stories/#{@story_foo.id}/comments/#{@comment1.id}/edit']"
    find(link).click
    fill_in "New Comment", with: "OK read" #should be fillin "Update Comment"
    click_button "Add Comment"#should be "update comment"
    
    expect(page).to have_content("OK read")
    expect(page).not_to have_content("Great story!")
  end
  
  scenario "A non-owner fails" do
    login_as(@foo, :scope => :user)
    
    visit "/"
    click_link @story_bar.title
    
    expect(page).not_to have_content("Edit")
    
  end
end