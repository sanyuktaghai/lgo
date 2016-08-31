require "rails_helper"

RSpec.feature "Adding Comments to Stories" do
  before do
    @foo = User.create(email: "foo@bar.com", password: "password")
    @foobar = User.create(email: "foobar@bar.com", password: "password")
    
    @story = Story.create(title: "The first story", body: "Body of first story", user: @foo)
  end
  
  scenario "Permit a signed in user to write a comment" do
    login_as(@foobar)
    
    visit "/"
    click_link @story.title
    fill_in "New Comment", with: "Great story!"
    click_button "Add Comment"
    
    expect(page).to have_content("Comment has been added")
    expect(page).to have_content("Great story!")
    expect(page.current_path).to eq(story_path(@story.comments.last.id))
  end
  
  
end
  