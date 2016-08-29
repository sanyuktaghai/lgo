require 'rails_helper'

RSpec.feature "Listing Stories" do 
  before do
    @story1 = Story.create(title: "The first story", body: "Body of first story")
    @story2 = Story.create(title: "The second story", body: "Body of second story")
  end
  
  scenario "List all stories" do
    visit "/"
    
    expect(page).to have_content(@story1.title)
    expect(page).to have_content(@story1.body)
    expect(page).to have_content(@story2.title)
    expect(page).to have_content(@story2.body)
    expect(page).to have_link(@story1.title)
    expect(page).to have_link(@story2.title)
  end
  
end