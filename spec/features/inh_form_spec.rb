require 'rails_helper'
require 'capybara/rails'

describe "rendering the forms generator" do
  before :each do
    visit "/"
    click_link "In House Register"
    fill_in "Username", with: "pgrunde"
    fill_in "Email", with: "pgrunde@gmail.com"
    fill_in "Password", with: "password"
    click_button "Join as an Inhouse Recruiter!"
    click_link "In House Login"
    fill_in "Username", with: "pgrunde"
    fill_in "Password", with: "password"
    click_button "Sign In"
  end

  it "in house user can view the form generator page" do
    expect(page).to have_link "Manage Forms"
  end
end