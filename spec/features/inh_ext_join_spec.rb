require 'rails_helper'
require 'capybara/rails'


describe "in order for both users to forge a contract together", focus: true do

  before :each do
    @inhouse_user = InhouseUser.create(username: "kipperton",
                                      email: "kipper@example.com",
                                      password_digest: "password")
    @external_user = ExternalUser.create(username: "nora",
                                        email:"nora@example.com",
                                        password_digest: "password")
    page.set_rack_session(:inhouse_user_id => @inhouse_user.id)
    visit search_for_ext_path
  end

  it "in house user can view a list of external recruiters with unpending contracts and request them" do
    expect(page).to have_content "nora"
    click_link "Request Contract"
    expect(page).to_not have_content "nora"
  end

  it "external user can view messages to notify a sent contract" do
    click_link "Request Contract"
    page.set_rack_session(:external_user_id => @external_user.id)
    visit ext_mainpage_path
    click_link "Pending Contract Requests"
    expect(page).to have_content "kipperton"
  end

  it "external user can approve a contract request and an inhouse user can be notified" do
    click_link "Request Contract"
    page.set_rack_session(:external_user_id => @external_user.id)
    visit ext_mainpage_path
    click_link "Pending Contract Requests"
    click_link "Send Contract"
    expect(page).to_not have_content "kipperton"
    page.set_rack_session(:inhouse_user_id => @inhouse_user.id)
  end

  

end
    # visit external_contracts_path
    # click_link "Approve Pending Contracts"
    # click_link "Approve Contract!"
