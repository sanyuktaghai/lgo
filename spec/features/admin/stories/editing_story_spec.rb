require 'rails_helper'

RSpec.feature "Editing Stories" do 
  before do
    @user = FactoryGirl.create(:user_with_stories)
    @admin = FactoryGirl.create(:admin)
    @story = Story.find_by(user_id: @user.id)
  end
  
  scenario "An admin edits a story" do
    login_as(@admin, :scope => :user)
    visit "/admin"
    
    click_link @story.raw_title
    click_link "Edit Story"
    
    #possibly a few more expectations here, such as, expect page to have the raw content for reference
    
    fill_in "Final Title", with: "Final Story Title"
    fill_in "Final Body", with: "Final story body"
    check 'Published'
    click_button "Update Story"
    
    expect(page).to have_content("Story has been updated")
    expect(page.current_path).to eq(admin_story_path(@story))  

    #should be a few more expectations in here, correct? Such as, then regular user can then see the published story on their index page (though maybe this is already handled in the other listing story tests), and the links should be final_titles all around
  end
end