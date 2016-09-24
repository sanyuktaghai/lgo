require 'rails_helper'

RSpec.feature "Listing Stories" do 
  before do
    @story1 = Story.create(raw_title: "The first story", raw_body: "Body of first story")
    @story2 = Story.create(raw_title: "The second story", raw_body: "Body of second story")
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