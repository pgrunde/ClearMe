require 'rails_helper'
require 'capybara/rails'

describe "viewing the homepage" do

  it "user can load the homepage and see two login links + register" do
    visit root_path
    expect(page).to have_link "In House Login"
    expect(page).to have_link "External Login"
    expect(page).to have_link "In House Register"
    expect(page).to have_link "External Register"
  end

  it "user can visit registration page for both in-house and external registers" do
    visit "/"
    click_link "In House Register"
    fill_in "Username", with: "pgrunde"
    fill_in "Email", with: "pgrunde@gmail.com"
    fill_in "Password", with: "password"
    click_button "Join as an Inhouse Recruiter!"
    expect(page).to have_content "Thanks for registering as an Inhouse Recruiter!"

    click_link "External Register"
    fill_in "Username", with: "pgrunde"
    fill_in "Email", with: "pgrunde@gmail.com"
    fill_in "Password", with: "password"
    click_button "Join as an External Recruiter!"
    expect(page).to have_content "Thanks for registering as an External Recruiter!"
  end

  it "user receives errors messages for failing to register properly (inh & ext)" do
    visit new_inhouse_user_path
    fill_in "Username", with: ""
    fill_in "Email", with: "pgrunde@gmail.com"
    fill_in "Password", with: "password"
    click_button "Join as an Inhouse Recruiter!"
    expect(page).to have_content "Username can't be blank"
    fill_in "Username", with: "pgrunde"
    fill_in "Email", with: ""
    fill_in "Password", with: "password"
    click_button "Join as an Inhouse Recruiter!"
    expect(page).to have_content "Email can't be blank"
    fill_in "Username", with: "pgrunde"
    fill_in "Email", with: "pgrunde@gmail.com"
    fill_in "Password", with: ""
    click_button "Join as an Inhouse Recruiter!"
    expect(page).to have_content "Password can't be blank"

    visit new_external_user_path
    fill_in "Username", with: ""
    fill_in "Email", with: "pgrunde@gmail.com"
    fill_in "Password", with: "password"
    click_button "Join as an External Recruiter!"
    expect(page).to have_content "Username can't be blank"
    fill_in "Username", with: "pgrunde"
    fill_in "Email", with: ""
    fill_in "Password", with: "password"
    click_button "Join as an External Recruiter!"
    expect(page).to have_content "Email can't be blank"
    fill_in "Username", with: "pgrunde"
    fill_in "Email", with: "pgrunde@gmail.com"
    fill_in "Password", with: ""
    click_button "Join as an External Recruiter!"
    expect(page).to have_content "Password can't be blank"
  end

end
