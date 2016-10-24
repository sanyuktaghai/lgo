require 'rails_helper'
require 'support/macros'

RSpec.feature "Creating Stories", :type => :feature do 
  
  before do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end
  
  scenario "A user creates a new story" do
    visit "/"
  
    click_link "New Story"
    
    fill_in "Title", with: Faker::Hipster::sentence
#    fill_in "Body", with: Faker::Hipster::paragraph
    fill_in_trix_editor('story_raw_body_trix_input_story', Faker::Hipster::paragraph)
    click_button "Contribute Story"
    
    expect(page).to have_content("Story has been submitted")
    expect(page.current_path).to eq(stories_path)
  end
  
  scenario "A user fails to create a new story", :js => true do
    visit "/"
    
    click_link "New Story"
    
    fill_in "Title", with: ""
#    fill_in "Body", with: ""
    fill_in_trix_editor('story_raw_body_trix_input_story', "")
    click_button "Contribute Story"
    assert_text("Title can't be blank")
    
    expect(page).to have_content("Story has not been submitted")
    expect(page).to have_content("Title can't be blank")
    expect(page).to have_content("Body can't be blank")
  end
end

