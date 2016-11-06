require "rails_helper"

RSpec.feature "Deleting Reaction_Lol" do
  before do
    @bar = FactoryGirl.create(:user_with_published_stories)
    @foo = FactoryGirl.create(:user_with_published_stories)
    @story_foo = Story.find_by(author_id: @foo.id)
    @story_bar = Story.find_by(author_id: @bar.id)
    @story_lol = Reaction.create(user: @foo, story: @story_bar, reaction_category_id: 3)
  end
  
  scenario "A user succeeds", :js => true do
    login_as(@foo, :scope => :user)
    
    visit "/"
    click_link @story_bar.final_title  
    click_link "UnLOL Story"
    
    expect(page).to have_content("LOL has been deleted")
    expect(page).to have_content("LOLs: 0")
    expect(page).to have_button("LOL Story")
    expect(page).not_to have_link("UnLOL Story")
  end
end