require 'rails_helper'

RSpec.feature "Listing Stories" do 
  before do
    @user = FactoryGirl.create(:user_with_stories, stories_count: 2)
    @admin = FactoryGirl.create(:admin)
    @story1 = Story.where(user_id: @user.id).first
    @story2 = Story.where(user_id: @user.id).last
    login_as(@admin, :scope => :user)
  end
  
  scenario "Logged-in admin can see list of all unpublished stories" do
    visit "/"
    
    expect(page).not_to have_content(@story1.raw_title)
    expect(page).not_to have_content(@story1.raw_body)
    expect(page).not_to have_link(@story1.raw_title)
    
    visit "/admin"
    expect(page).to have_content(@story1.raw_title)
    expect(page).to have_content(@story1.raw_body)
    expect(page).to have_link(@story1.raw_title)
    expect(page).to have_content(@story2.raw_title)
    expect(page).to have_content(@story2.raw_body)
    expect(page).to have_link(@story2.raw_title)
  end
  
end