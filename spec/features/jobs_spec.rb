require 'rails_helper'
require 'capybara/rails'

describe "job CRUD cycle" do

  before :each do
    @inhouse_user = InhouseUser.create(username: "kipperton",
                                      email: "kipper@example.com",
                                      password_digest: "password")
    @form = Form.create(title:"Form",
                        inh_user_id:@inhouse_user.id)
    @job = Job.create(title:"batman",
                     description:"fanciest-pants experience needed required",
                     location:"Gotham City",
                     inh_user_id:@form.id)
    page.set_rack_session(:inhouse_user_id => @inhouse_user.id)
    visit jobs_path
  end

  it "in house user can view a form to create a new job" do
    click_link "Add New Job"
    expect(page).to have_content "Title Description Location Select Intro Form"
  end

  it "in house user can fill in and create a new form" do
    click_link "Add New Job"
    fill_in "Title", with: "Robin"
    fill_in "Description", with: "The rogue protector friend guy of Gotham."
    fill_in "Location", with: "Gotham City"
    select "Form", from: "Select Intro Form"
    click_button "Create New Job"
    expect(page).to have_content "Robin"
  end

  it "in house user can click to delete a created form" do
    find(".job-delete").click
    expect(page).to_not have_content "batman"
  end

  it "in house user can click to edit a form" do
    click_link "batman"
    fill_in "Title", with: "The Dark Knight"
    click_button "Update Job"
    expect(page).to have_content "The Dark Knight"
  end

end
