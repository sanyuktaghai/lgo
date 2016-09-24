require 'rails_helper'

RSpec.feature "Deleting Stories" do 
  
  before do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    @story = Story.create(raw_title: "The first story", raw_body: "Body of first story", user: user)
  end
  
  scenario "A user deletes a story" do
    visit "/"
    
    click_link @story.raw_title
    click_link "Delete Story"
    
    expect(page).to have_content("Story has been deleted")
    expect(page.current_path).to eq(stories_path)   
  end
end