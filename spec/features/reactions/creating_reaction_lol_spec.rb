require "rails_helper"

RSpec.feature "Adding Reaction_Lol to Stories" do
  before do
    @bar = FactoryGirl.create(:user)
    @foo = FactoryGirl.create(:user_with_published_stories)
    @story = Story.find_by(author_id: @foo.id)
    ReactionCategory.create(id: 3, name: 'lol')
  end
  
  scenario "Permit a signed in user to lol a story", :js => true do
    login_as(@bar, :scope => :user)
    
    visit "/"
    click_link @story.final_title
  
    click_link "LOL Story"
    
    expect(page).to have_content("LOLs: 1")
    expect(page.current_path).to eq(story_path(@story))
  end
  
  scenario "A non-signed in user fails to lol a story" do
    visit "/"
    click_link @story.final_title
    
    click_link "LOL Story"
    
    expect(page).to have_content("You need to sign in or sign up before continuing.")
    expect(page.current_path).to eq(new_user_session_path)
  end
end
