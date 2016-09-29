require 'rails_helper'

RSpec.feature "Showing Dashboard" do 
  before do
    @user = FactoryGirl.create(:user_with_published_stories)
    @user2 = FactoryGirl.create(:user)
    @user2.update(about_me: "")
  end
  
  scenario "Logged-in user can see her basic profile information on the dashboard" do
    login_as(@user, :scope => :user)
    visit(dashboard_path(@user))
    
    expect(page).to have_content(@user.first_name.titleize.gsub(/\b\w/) { |w| w.upcase })
    expect(page).to have_content(@user.last_name.titleize.gsub(/\b\w/) { |w| w.upcase })
    expect(page).to have_content(@user.about_me)
  end
  
  scenario "Logged-in user with blank 'About Me' does not see 'About Me' title" do
    login_as(@user2, :scope => :user)
    visit(dashboard_path(@user2))
    
    expect(page).not_to have_content("About Me")
  end
  
  scenario "Non-logged-in user can go to other user's dashboards" do
    visit "/"
    
    click_link "#{@user.first_name.titleize.gsub(/\b\w/) { |w| w.upcase }} #{@user.last_name.titleize.gsub(/\b\w/) { |w| w.upcase }}"
    expect(page).to have_current_path(dashboard_path(@user))
  end

end