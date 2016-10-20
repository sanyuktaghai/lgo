require 'rails_helper'

RSpec.feature "Users signup" do
  
  before do
    @email = Faker::Internet.email
    @password = Faker::Internet.password
    @password2 = Faker::Internet.password
  end
  
  scenario "with valid credentials" do
    visit "/"
    
    click_link "Sign up"
    fill_in "Email", with: @email
    fill_in "Password", with: @password
    fill_in "Password confirmation", with: @password
    
    click_button "Sign up"
    
    expect(page.current_path).to eq(registration_step_path(:basic_details)) 
    expect(page).not_to have_content("Signed in as #{@email}")
    
    fill_in "First Name", with: Faker::Name.first_name
    fill_in "Last Name", with: Faker::Name.last_name
    
    click_button "Submit"
    
    expect(page).to have_content("You have signed up successfully.")
    expect(page).to have_content("Signed in as #{@email}")
  end
  
  scenario "with invalid credentials - step 1" do
    visit "/"
    
    click_link "Sign up"
    fill_in "Email", with: ""
    fill_in "Password", with: ""
    
    click_button "Sign up"
    
    expect(page).to have_content("Email can't be blank")
    expect(page).to have_content("Password can't be blank")
  end
  
  scenario "with invalid credentials - step 2", :js => true do
    visit "/"
    
    click_link "Sign up"
    fill_in "Email", with: Faker::Internet.email
    fill_in "Password", with: @password2
    fill_in "Password confirmation", with: @password2
    
    click_button "Sign up"
    
    fill_in "First Name", with: ""
    fill_in "Last Name", with: ""
    
    click_button "Submit"
    
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
  end
end