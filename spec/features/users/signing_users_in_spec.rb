require 'rails_helper'

RSpec.feature "Users sign in" do
  
  before do
    @foo = FactoryGirl.create(:user)
  end
  
  scenario "with valid credentials" do
    visit "/"
    
    click_link "Sign in"
    fill_in "Email", with: @foo.email
    fill_in "Password", with: @foo.password
    click_button "Log in"
    
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@foo.email}.")
  end
end