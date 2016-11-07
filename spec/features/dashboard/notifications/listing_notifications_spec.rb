require 'rails_helper'

RSpec.feature "Listing Notifications" do 
  before do
    @foo = FactoryGirl.create(:user)
    @bar = FactoryGirl.create(:user)
    NotificationCategory.create(id: 1, name: "following")
    Notification.create(user: @foo, notified_by_user_id: @bar, notification_category_id: 1, read: false)
    login_as(@foo, :scope => :user)
  end
  
  scenario "Shows list of user's notifications", js: true do
    visit(dashboard_path(@foo))
    click_link "Notifications"
    
    expect(page).to have_content("#{@foo.full_name} followed you.")
  end
end