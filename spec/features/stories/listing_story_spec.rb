require 'rails_helper'

RSpec.feature "Listing Stories" do 
  before do
    @user = FactoryGirl.create(:user_with_published_stories, stories_count: 2)
    @story1 = Story.where(user_id: @user.id).first
    @story2 = Story.where(user_id: @user.id).last
  end
  
  scenario "List all stories" do
    visit "/"
    
    expect(page).to have_content(@story1.raw_title)
    expect(page).to have_content(@story1.raw_body)
    expect(page).to have_content(@story2.raw_title)
    expect(page).to have_content(@story2.raw_body)
    expect(page).to have_link(@story1.raw_title)
    expect(page).to have_link(@story2.raw_title)
    expect(page).not_to have_link("New Story")
  end
  
end