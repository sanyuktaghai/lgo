require 'rails_helper'

RSpec.feature "Showing Stories" do 
  before do
    @story = Story.create(title: "The first story", body: "Body of first story")
  end
  
  scenario "Display individual story" do
    visit "/"
    
    click_link @story.title
    
    expect(page).to have_content(@story.title)
    expect(page).to have_content(@story.body)
    expect(current_path).to eq(story_path(@article))
  end
  
end