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
  
  scenario "An owner succeeds", :js => true do
    login_as(@foo, :scope => :user)
    
    visit "/"
    click_link @story_foo.title
    
    link = "a[href='/stories/#{@story_foo.id}/comments/#{@comment1.id}/edit']"
    find(link).click
    expect(page).to have_field('Edit Comment', :with => "Great story!")
    within("#edit_comment_#{@comment1.id}"){fill_in("Edit Comment", with: "OK read" )}
    click_button "Update Comment"
    
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