require 'rails_helper'

RSpec.feature "Deleting Stories" do 
  
  before do
    foo = User.create(email: "foo@bar.com", password: "password")
    login_as(foo)
    @story = Story.create(title: "The first story", body: "Body of first story", user: foo)
  end
  
  scenario "A user deletes a story" do
    visit "/"
    
    click_link @story.title
    click_link "Delete Story"
    
    expect(page).to have_content("Story has been deleted")
    expect(page.current_path).to eq(stories_path)   
  end
end