require 'rails_helper'

RSpec.feature "Deleting Stories" do 
  
  before do
    @user = FactoryGirl.create(:user_with_stories)
    login_as(@user, :scope => :user)
    @story = Story.find_by(user_id: @user.id)
  end
  
  scenario "A user deletes a story" do
    visit "/"
    click_link @story.raw_title
    
    click_link "Delete Story"
    
    expect(page).to have_content("Story has been deleted")
    expect(page.current_path).to eq(stories_path)   
  end
end