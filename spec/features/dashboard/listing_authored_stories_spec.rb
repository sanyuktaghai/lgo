require 'rails_helper'

RSpec.feature "Listing Stories" do 
  before do
    @user = FactoryGirl.create(:user_with_unpublished_stories, stories_count: 4)
    @story1 = Story.where(author_id: @user.id).first
    @story2 = Story.where(author_id: @user.id).second
    @story3 = Story.where(author_id: @user.id).third
    @story4 = Story.where(author_id: @user.id).last
    @story3.update(published: true, final_title: Faker::Hipster.sentence, final_body: Faker::Hipster.paragraph)
    @story4.update(published: true, final_title: Faker::Hipster.sentence, final_body: Faker::Hipster.paragraph, anonymous: true)
    login_as(@user, :scope => :user)
  end
  
  scenario "Logged-in user can see full list of her published, unpublished, and anonymous stories" do
    visit(dashboard_path(@user))
    expect(page).to have_content("Stories: 4")
    
    expect(page).to have_content(Story.where(author_id: @user.id).count)
    expect(page).to have_content(@story1.raw_title)
    expect(page).to have_content(@story1.raw_body.truncate(150))
    expect(page).to have_link(@story1.raw_title)
    expect(page).to have_content(@story2.raw_title)
    expect(page).to have_content(@story2.raw_body.truncate(150))
    expect(page).to have_link(@story2.raw_title)
    expect(page).to have_content(@story3.final_title)
    expect(page).to have_content(@story3.final_body.truncate(150))
    expect(page).to have_link(@story3.final_title)
    expect(page).to have_content("Pending")
    
    expect(page).to have_content(@story4.final_title)
    expect(page).to have_content(@story4.final_body.truncate(150))
    expect(page).to have_link(@story4.final_title)
    expect(page).to have_content("Anonymous")
   end
  
  scenario "Logged-in user can click back to her full list of published and unpublished stories", js: true do
    visit(dashboard_path(@user))
    click_link "Saves"
    click_link "Stories"
    
    expect(page).to have_content(@story1.raw_title)
    expect(page).to have_content(@story1.raw_body.truncate(150))
    expect(page).to have_link(@story1.raw_title)
    expect(page).to have_content(@story2.raw_title)
    expect(page).to have_content(@story2.raw_body.truncate(150))
    expect(page).to have_link(@story2.raw_title)
    expect(page).to have_content(@story3.final_title)
    expect(page).to have_content(@story3.final_body.truncate(150))
    expect(page).to have_link(@story3.final_title)
   end
end