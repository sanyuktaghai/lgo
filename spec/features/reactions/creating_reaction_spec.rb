require "rails_helper"

RSpec.feature "Adding Reaction_Lol to Stories" do
  before do
    @bar = FactoryGirl.create(:user)
    @foo = FactoryGirl.create(:user_with_published_stories)
    @story = Story.find_by(author_id: @foo.id)
    ReactionCategory.create([
      {id: 1, name: 'like'}, 
      {id: 2, name: 'omg'}, 
      {id: 3, name: 'lol'}, 
      {id: 4, name: 'cool'}, 
      {id: 5, name: 'love'}
      ])
  end
  
  scenario "Permit a signed in user to lol a story", :js => true do
    login_as(@bar, :scope => :user)
    
    visit "/"
    click_link @story.final_title
  
    click_on "Like Story"
    click_on "OMG Story"
    click_on "LOL Story"
    click_on "Cool Story"
    click_on "Love Story"
    
    expect(page).to have_content("Likes: 1")
    expect(page).to have_content("OMGs: 1")
    expect(page).to have_content("LOLs: 1")
    expect(page).to have_content("Cools: 1")
    expect(page).to have_content("Loves: 1")
    expect(page.current_path).to eq(story_path(@story))
  end
  
  scenario "A non-signed in user fails to lol a story" do
    visit "/"
    click_link @story.final_title
    
    click_on "LOL Story"
    
    expect(page).to have_content("You need to sign in or sign up before continuing.")
    expect(page.current_path).to eq(new_user_session_path)
  end
end
