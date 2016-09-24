require 'rails_helper'

RSpec.feature "Showing Stories" do 
  before do
    @bar = FactoryGirl.create(:user)
    @foo = FactoryGirl.create(:user_with_stories, stories_count: 1)
#    @story = Story.create(raw_title: "The first story", raw_body: "Body of first story", user: @foo)
    @story = Story.find_by(user_id: @foo.id)
  end
  
  scenario "A non-signed in user does not see edit or delete links" do
    visit "/"
    
    click_link @story.raw_title
    
    expect(page).to have_content(@story.raw_title)
    expect(page).to have_content(@story.raw_body)
    expect(current_path).to eq(story_path(@story))
    
    expect(page).not_to have_link("Edit Story")
    expect(page).not_to have_link("Delete Story")
  end
  
  scenario "A non-owner signed in does not see edit or delete links" do
    login_as(@bar, :scope => :user)
    
    visit "/"
    
    click_link @story.raw_title
    
    expect(page).to have_content(@story.raw_title)
    expect(page).to have_content(@story.raw_body)
    expect(current_path).to eq(story_path(@story))
    
    expect(page).not_to have_link("Edit Story")
    expect(page).not_to have_link("Delete Story")
  end
  
  scenario "A signed-in owner sees both edit and delete links" do
    login_as(@foo, :scope => :user)
    
    visit "/"
    
    click_link @story.raw_title
    
    expect(page).to have_content(@story.raw_title)
    expect(page).to have_content(@story.raw_body)
    expect(current_path).to eq(story_path(@story))
    
    expect(page).to have_link("Edit Story")
    expect(page).to have_link("Delete Story")
  end
  
  scenario "Display individual story" do
    visit "/"
    
    click_link @story.raw_title
    
    expect(page).to have_content(@story.raw_title)
    expect(page).to have_content(@story.raw_body)
    expect(current_path).to eq(story_path(@story))
  end
  
end