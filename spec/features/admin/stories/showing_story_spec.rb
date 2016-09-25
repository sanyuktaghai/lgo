require 'rails_helper'

RSpec.feature "Showing Stories" do 
  before do
    @user = FactoryGirl.create(:user_with_stories)
    @admin = FactoryGirl.create(:admin)
    @story = Story.find_by(user_id: @user.id)
    login_as(@admin, :scope => :user)
  end
  
  scenario "Logged-in admin can see individual story" do
    visit "/admin"
    
    click_link @story.raw_title
    expect(page).to have_content(@story.user(:author_id).email)
    expect(page).to have_content(@story.created_at.strftime("%b %d, %Y"))
    expect(page).to have_content("Unpublished")
    expect(page).to have_content(@story.raw_title)
    expect(page).to have_content(@story.raw_body)
    expect(current_path).to eq(admin_story_path(@story))
    expect(page).to have_link("Edit Story")
    expect(page).to have_link("Delete Story")
  end
end