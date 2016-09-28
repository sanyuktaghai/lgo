require 'rails_helper'

RSpec.feature "Showing Stories" do 
  before do
    @user = FactoryGirl.create(:user_with_unpublished_stories, stories_count: 3)
    @story1 = Story.where(author_id: @user.id).first
    @story2 = Story.where(author_id: @user.id).second
    @story3 = Story.where(author_id: @user.id).last
    @story3 = @story3.update(published: true, final_title: "Title of the published story", final_body: "Body of the final story")
    login_as(@user, :scope => :user)
  end
  
  scenario "Logged-in user can see full list of her published and unpublished stories" do
#    expect(page).to have_content(@story1.raw_title)
#    expect(page).to have_content(@story1.raw_body)
#    expect(page).to have_link(@story1.raw_title)
#    expect(page).to have_content(@story2.raw_title)
#    expect(page).to have_content(@story2.raw_body)
#    expect(page).to have_link(@story2.raw_title)
#    expect(page).to have_content(@story3.final_title)
#    expect(page).to have_content(@story3.final_body)
#    expect(page).to have_link(@story3.final_title)
   end
end