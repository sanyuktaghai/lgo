require 'rails_helper'

RSpec.feature "Showing Dashboard" do 
  before do
    @user = FactoryGirl.create(:user)
    login_as(@user, :scope => :user)
  end
  
  scenario "Logged-in user can see her basic profile information on the dashboard" do
    visit(dashboard_path(@user))
    
    expect(page).to have_content(@user.first_name)
    expect(page).to have_content(@user.last_name)
  end

end