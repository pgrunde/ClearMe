require 'rails_helper'
require 'capybara/rails'


describe "in order for both users to forge a contract together" do

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

  it "external user can approve a contract request and an inhouse user can seal the contract" do
    click_link "Request Contract"
    page.set_rack_session(:external_user_id => @external_user.id)
    visit ext_mainpage_path
    click_link "Pending Contract Requests"
    click_link "Send Contract"
    expect(page).to_not have_content "kipperton"
    page.set_rack_session(:inhouse_user_id => @inhouse_user.id)
    visit inhouse_contracts_path
    click_link "Approve Pending Contracts"
    expect(page).to have_content "Approve Contract!"
    click_link "Approve Contract!"
    expect(page).to_not have_content "Approve Contract!"
  end

  it "once a contract is in place an external user can view the jobs of their joined inhouse users" do
    join = InhExtContract.create(ext_user_id:@external_user.id,
                                 inh_user_id:@inhouse_user.id,
                                 ext_accepted:true,
                                 inh_accepted:true)
    form = Form.create(title:"form",
                       inh_user_id:@inhouse_user.id,
                       json:[{"type"=>"text-area", "title"=>"Test"}])
    job = Job.create(title:"poop scooper",
                     description:"scoop the poop",
                     location:"Westminster, CO",
                     form_id:form.id,
                     inh_user_id: @inhouse_user.id)
    page.set_rack_session(:external_user_id => @external_user.id)
    visit ext_mainpage_path
    click_link "View Client Jobs"
    expect(page).to have_content "poop scooper"
    expect(page).to have_content "scoop the poop"
    expect(page).to have_content "Westminster, CO"
  end

end
