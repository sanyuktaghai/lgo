require 'rails_helper'

RSpec.feature "Listing Notifications" do 
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    NotificationCategory.create([
      {id: 1, name: "Story"},
      {id: 2, name: "Comment"},
      {id: 3, name: "Reaction"},
      {id: 4, name: "Bookmark"},
      {id: 5, name: "Following"}
      ])
    Notification.create(user: @foo, notified_by_user: @bar, notification_category_id: 5, read: false)
    login_as(@foo, :scope => :user)
  end
  
  scenario "Shows list of user's notifications", js: true do
    visit(dashboard_path(@foo))
    click_link "Notifications"
    
    expect(page).to have_content("#{@bar.full_name} followed you.")
    expect(page).to have_link("#{@bar.full_name}")
  end
end