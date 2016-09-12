require 'rails_helper'

RSpec.feature "Creating Stories", :type => :feature do 
  
  before do
    @foo = User.create!(email: "foo@bar.com", password: "password")
    login_as(@foo)
  end
  
  scenario "A user creates a new story" do
    visit "/"
    
    expect(page).to have_content("Signed in as")
    
    click_link "New Story"
#    click_button "New Story"
    
    fill_in "Title", with: "Creating first story"
    fill_in "Body", with: "Lorem Ipsum"
    click_button "Create Story"
    
    expect(page).to have_content("Story has been submitted")
    expect(page.current_path).to eq(stories_path)
    expect(page).to have_content("Created by: #{@foo.email}")
  end
  
  scenario "A user fails to create a new story" do
    visit "/"
    
    click_link "New Story"
    
    fill_in "Title", with: ""
    fill_in "Body", with: ""
    click_button "Create Story"
    
    expect(page).to have_content("Story has not been submitted")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
    
  end
end