require 'rails_helper'

RSpec.feature "Users sign in" do
  
  before do
    @foo = User.create(email: "foo@bar.com", password: "password")
  end
  
  scenario "with valid credentials" do
    visit "/"
    
    click_link "Sign in"
    fill_in "Email", with: "foo@bar.com"
    fill_in "Password", with: "password"
    click_button "Log in"
    
    expect(page).to have_content("Signed in successfully.")
    expect(page).to have_content("Signed in as #{@foo.email}.")
  end
end