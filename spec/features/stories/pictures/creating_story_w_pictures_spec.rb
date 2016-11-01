require 'rails_helper'
require 'support/macros'

RSpec.feature "Creating Stories with Pictures", :type => :feature do 
  
  before do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
    visit "/"
    click_link "New Story"
    @title = Faker::Hipster::sentence
    fill_in "Title", with: @title
    fill_in_trix_editor('story_raw_body_trix_input_story', Faker::Hipster::paragraph)
  end
  
  scenario "A user creates a new story w picture" do
    attach_file('image[]', './spec/fixtures/image.png')
    click_button "Contribute Story"
    
    expect(page).to have_content("Story has been submitted")
    expect(page.current_path).to eq(dashboard_path(@user))
    
    click_link @title
    expect(page).to have_css("img[src*='image.png']")
  end
#  scenario "A user fails to create a new story", :js => true do
#    visit "/"
#    
#    click_link "New Story"
#    
#    fill_in "Title", with: ""
##    fill_in "Body", with: ""
#    fill_in_trix_editor('story_raw_body_trix_input_story', "")
#    click_button "Contribute Story"
#    assert_text("Title can't be blank")
#    
#    expect(page).to have_content("Story has not been submitted")
#    expect(page).to have_content("Title can't be blank")
#    expect(page).to have_content("Body can't be blank")
#  end
end
