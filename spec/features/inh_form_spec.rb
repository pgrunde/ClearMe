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
    click_link "Manage Forms"
    click_link "Add form"
  end

  it "in house user can view the form generator page" do
    expect(page).to have_content "Contact Info"
    expect(page).to have_content "Text"
    expect(page).to have_content "Text Area"
  end

  it "in house user can click 'Text' to see Text options and display fill", :js => true do
    find("#text-select").click
    expect(page).to have_content "Text Input Title"
    fill_in "title", with: "Test Title"
    within("#display-form") do
      expect(page).to have_content("Test Title")
    end
  end

  it "in house user can click 'Text Area' to see Text Area options and display fill", :js => true do
    find("#text-area").click
    expect(page).to have_content "Text Area Input Title"
    fill_in "title", with: "Test Title"
    within("#display-form") do
      expect(page).to have_content("Test Title")
    end
  end

  it "in house user can click 'checkbox-select' to see its options and display fill", :js => true do
    find("#checkbox-select").click
    expect(page).to have_content "Checkbox Select Title"
    fill_in "title", with: "Test Title"
    select '2', from: 'number'
    fill_in "checkbox1", with: "Box 1"
    fill_in "checkbox2", with: "Box 2"
    within("#display-form") {expect(page).to have_content("Box 1")}
    within("#display-form") {expect(page).to have_content("Box 2")}
    within("#display-form") {expect(page).to have_content("Test Title")}
  end

end