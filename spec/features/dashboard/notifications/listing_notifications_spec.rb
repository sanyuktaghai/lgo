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
    @story = Story.create(
      final_title: Faker::Hipster.sentence,
      published: true,
      poster_id: @foo.id)
    Notification.create(user: @foo, notified_by_user: @bar, notification_category_id: 5, read: false)
    Notification.create(user: @foo, notification_category_id: 1, read: false, origin_id: @story.id)
    login_as(@foo, :scope => :user)
  end
  
  scenario "Shows list of user's notifications", js: true do
    visit(dashboard_path(@foo))
    click_link "Notifications"
    
    #published story notifications
    expect(page).to have_content("Your story has been published: ")
    expect(page).to have_content(@story.final_title)
    
    #followings notifications
    expect(page).to have_content("#{@bar.full_name} followed you.")
    expect(page).to have_link("#{@bar.full_name}")
  end
end