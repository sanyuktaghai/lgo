require 'rails_helper'

RSpec.feature "ListingFollowings" do 
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    
    @following = Following.create(user: @foo, follower: @bar)
    login_as(@bar, :scope => :user)
  end
  
  scenario "Owner succeeds in deleting following via user's dashboard" do
    visit(dashboard_path(@foo))
    expect(page).to have_content("Followers: 1")
    click_link "Unfollow"
 
    expect(page).to have_content("Followers: 0")
    expect(page).to have_content("You unfollowed #{@foo.full_name}")
    expect(page).to have_link("Follow", href: "/followings?user_id=#{@foo.id}")
  end
  
  
#   scenario "Owner succeeds in deleting following via own dashboard", js: true do
#    login_as(@foo, :scope => :user)
#    visit(dashboard_path(@foo))
#    click_link "Following"
#    
#    expect(page).to have_content(Following.where(follower_id: @foo).count)
#    expect(page).to have_content("Following: 1")
#    expect(page).to have_content(@car.full_name) 
#    expect(page).to have_link("Unfollow")
#  end
end