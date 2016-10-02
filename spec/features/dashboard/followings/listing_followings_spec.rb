require 'rails_helper'

RSpec.feature "ListingFollowings" do 
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    @car = FactoryGirl.create(:user)
#    @following = FactoryGirl.create(:following)
#    @following.update(user_id: @foo.id, follower_id: @bar.id)
    
    @following = Following.create(user: @foo, follower: @bar)
    @following = Following.create(user: @car, follower: @foo)
    login_as(@foo, :scope => :user)
  end
  
  scenario "Shows list of owner's followers" do
    
    visit(dashboard_path(@foo))
    click_link "Followers"
    
    expect(page).to have_content(Following.where(user: @foo).count)
    expect(page).to have_content("Followers: 1")
    expect(page).to have_content(@bar.full_name) 
  end
  
  scenario "Shows list of users who owner follows" do
    
    visit(dashboard_path(@foo))
    click_link "Following"
    
    expect(page).to have_content(Following.where(follower_id: @foo).count)
    expect(page).to have_content("Following: 1")
    expect(page).to have_content(@car.full_name) 
    expect(page).to have_link("Unfollow")
  end
end
