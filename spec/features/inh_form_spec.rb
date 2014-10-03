require 'rails_helper'
require 'capybara/rails'


describe "rendering the forms generator" do

  before :each do
    inhouse_user = InhouseUser.create(username: "kipperton",
                                      email: "kipper@example.com",
                                      password_digest: "password")
    page.set_rack_session(:inhouse_user_id => inhouse_user.id)
    visit new_form_path
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
    select '2', from: 'chkbx-count'
    fill_in "chkbx-text-input:1", with: "Box 1"
    fill_in "chkbx-text-input:2", with: "Box 2"
    within("#display-form") { expect(page).to have_content("Box 1") }
    within("#display-form") { expect(page).to have_content("Box 2") }
    within("#display-form") { expect(page).to have_content("Test Title") }
  end

  it "in house user can click 'radio-select' to see its options and display fill", :js => true do
    find("#radio-select").click
    fill_in "title", with: "Test Title"
    select '2', from: 'radio-count'
    fill_in "radio-text:1", with: "Radio 1"
    fill_in "radio-text:2", with: "Radio 2"
    within("#display-form") { expect(page).to have_content("Radio 1") }
    within("#display-form") { expect(page).to have_content("Radio 2") }
    within("#display-form") { expect(page).to have_content("Test Title") }
  end

  it "in house user can click 'date-select' to see its options and display fill", :js => true do
    find("#date-select").click
    expect(page).to have_content "Date Select Title"
    fill_in "title", with: "Test Title"
    within("#display-form") do
      expect(page).to have_content("Test Title")
    end
  end

  it "in house user can click 'dropdown-select' to see its options and display fill", :js => true do
    find("#dropdown-select").click
    expect(page).to have_content "Dropdown Select Title"
    fill_in "title", with: "Test Title"
    select '2', from: 'dropdown-count'
    fill_in "dropdown-text:1", with: "down 1"
    fill_in "dropdown-text:2", with: "down 2"
    within("#display-form") { expect(page).to have_content("down 1") }
    within("#display-form") { expect(page).to have_content("down 2") }
    within("#display-form") { expect(page).to have_content("Test Title") }
  end

  it "in house user can click 'website' to see options and display fill", :js => true do
    find("#url-select").click
    expect(page).to have_content "Website Title"
    fill_in "title", with: "Test Title"
    within("#display-form") { expect(page).to have_content("Test Title") }
  end

  it "in house user can save a created form and see it render on the index page", :js => true do
    find("#dropdown-select").click
    fill_in "title", with: "Test Title"
    select '2', from: 'dropdown-count'
    fill_in "dropdown-text:1", with: "down 1"
    fill_in "dropdown-text:2", with: "down 2"
    find("#add-to-ff").click
    find("#text-area").click
    fill_in "title", with: "Test Title"
    find("#add-to-ff").click
    fill_in("Form Name", :with => "Test Form")
    find(".save-button").click
    expect(page).to have_content "Test Form"
  end

end

describe "editing an existing form" do
  before :each do
    inhouse_user = InhouseUser.create(username: "kipperton",
                                      email: "kipper@example.com",
                                      password_digest: "password")
    page.set_rack_session(:inhouse_user_id => inhouse_user.id)
    @generated_form = Form.create(title: "testing form",
                                 inh_user_id: inhouse_user.id,
                                 json:[{"type"=>"text-area", "title"=>"Test"},
 {"type"=>"checkbox", "title"=>"Test", "options"=>["", "", "", "", ""]},
 {"type"=>"radio", "title"=>"radio", "options"=>["", "", ""]},
 {"type"=>"date", "title"=>"date"},
 {"type"=>"dropdown", "title"=>"dropdow", "options"=>["", "", ""]},
 {"type"=>"dropdown", "title"=>"Select", "options"=>["one", "two", "three"]},
 {"type"=>"url", "title"=>"Github"},
 {"type"=>"text", "title"=>"Text"}])
    visit forms_path
  end

  it "in house user can click a created form to view and edit it", :js => true do
    click_link "testing form"
    expect(page).to have_content "Test"
    expect(page).to have_content "Github"
  end

  it "in house user can delete a created form", :js => true do
    find(".fa-close").click
    expect(page).to_not have_content "testing form"
  end

  it "in house user can remove a single input from an existing form and the input will not persist", :js => true do
    click_link "testing form"
    find("#removeinput-6").click
    expect(page).to_not have_content "Github"
    find(".update-button").click
    click_link "testing form"
    expect(page).to_not have_content "Github"
  end

  it "in house user can edit a form, update the title, and the edit will persist", :js => true do
    click_link "testing form"
    find("#text-select").click
    fill_in "title", with: "I am an edited form title"
    find("#add-to-ff").click
    fill_in "Form Name", :with => "new form name"
    expect(page).to have_content "I am an edited form"
    find(".update-button").click
    click_link "new form name"
    expect(page).to have_content "I am an edited form title"
  end

end