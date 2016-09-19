require 'rails_helper'

RSpec.feature "Deleting Stories" do 
  
  before do
    user = FactoryGirl.create(:user)
    login_as(user, :scope => :user)
    @story = Story.create(title: "The first story", body: "Body of first story", user: user)
  end
  
  scenario "A user deletes a story" do
    visit "/"
    
    click_link @story.title
    click_link "Delete Story"
    
    expect(page).to have_content("Story has been deleted")
    expect(page.current_path).to eq(stories_path)   
  end
end