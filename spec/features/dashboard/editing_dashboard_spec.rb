require 'rails_helper'

RSpec.feature "Editing Dashboard" do 
  before do
    @user = FactoryGirl.create(:user)
    @new_first_name = Faker::Name::first_name
    @new_last_name = Faker::Name::last_name
    @new_about_me = Faker::Hipster::sentence
  end
  
  scenario "Logged-in user can edit her basic profile information on the dashboard", js:true do
    login_as(@user, :scope => :user)
    visit(dashboard_path(@user))
    click_link "Edit"
    
    fill_in "First Name", with: @new_first_name
    fill_in "Last Name", with: @new_last_name
    fill_in "About Me", with: @new_about_me
    click_button "Update"
    
    expect(page).to have_content(@user.first_name.titleize.gsub(/\b\w/) { |w| w.upcase })
    expect(page).to have_content(@new_first_name.titleize.gsub(/\b\w/) { |w| w.upcase })
    expect(page).to have_content(@user.last_name.titleize.gsub(/\b\w/) { |w| w.upcase })
    expect(page).to have_content(@new_last_name.titleize.gsub(/\b\w/) { |w| w.upcase })
    expect(page).to have_content(@user.about_me)
    expect(page).to have_content(@new_about_me)
  end

end