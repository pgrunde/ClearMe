require 'rails_helper'
require 'capybara/rails'

describe "manage their candidates" do
  before :each do
    @inhouse_user = InhouseUser.create(username: "kipperton",
                                       email: "kipper@example.com",
                                       password_digest: "password")
    @external_user = ExternalUser.create(username: "nora",
                                         email:"nora@example.com",
                                         password_digest: "password")
    @join = InhExtContract.create(ext_user_id:@external_user.id,
                                 inh_user_id:@inhouse_user.id,
                                 ext_accepted:true,
                                 inh_accepted:true)
    @form = Form.create(title:"form",
                       inh_user_id:@inhouse_user.id,
                       json:[{"type"=>"text-area", "title"=>"Test"}])
    @job = Job.create(title:"poop scooper",
                     description:"scoop the poop",
                     location:"Westminster, CO",
                     form_id:@form.id,
                     inh_user_id: @inhouse_user.id)
    @candidate = Candidate.create(first_name:"Daniel",
                                 last_name:"Sickles",
                                 title:"Politician, Solider, and Diplomat",
                                 bio:"The craziest guy in the Union",
                                 state:"active",
                                 external_user_id:@external_user.id)
    page.set_rack_session(:external_user_id => @external_user.id)
    visit ext_candidate_mgmt_path
  end

  it "ext users can create new candidates for the inhouse user" do
    click_link "Create New Candidate"
    expect(page).to have_content "Create New Candidate"
    fill_in "First name", with: "Icarus"
    fill_in "Last name", with: "Grunde"
    fill_in "Title", with: "Sugar Glider"
    fill_in "Bio", with: "A fantastic marsupial of flight"
    click_button "Create New Candidate"
    expect(page).to have_content "Candidate Created"
  end

  it "ext users can view a list of all their candidates" do
    click_link "View All Candidates"
    expect(page).to have_content "All Candidates"
    expect(page).to have_content "Daniel Sickles"
  end

  it "ext users can view a submittable candidate for a job via the Client Jobs page" do
    visit external_jobs_path
    click_link "Submit a Candidate!"
    expect(page).to have_content "poop scooper"
  end

end