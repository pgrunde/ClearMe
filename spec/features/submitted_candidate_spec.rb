require 'rails_helper'
require 'capybara/rails'

describe "submitted candidates are visible", focus: true do

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
                        json:[{"type"=>"text-area", "title"=>"text-area"},
                              {"type"=>"checkbox", "title"=>"checkbox", "options"=>["check-one", "check-two", "check-three", "check-four", "check-five"]},
                              {"type"=>"radio", "title"=>"radio", "options"=>["radio-one", "radio-two", "radio-three"]},
                              {"type"=>"date", "title"=>"date"},
                              {"type"=>"dropdown", "title"=>"dropdown", "options"=>["dropdown-one", "dropdown-two", "dropdown-three"]},
                              {"type"=>"url", "title"=>"url"},
                              {"type"=>"text", "title"=>"text"}])
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
  end

  it "external user can view a candidate submit form via link on the job view page", :js => true do
    page.set_rack_session(:external_user_id => @external_user.id)
    visit ext_mainpage_path
    click_link "View Client Jobs"
    click_link "Submit a Candidate!"
    expect(page).to have_content "scoop the poop"
    expect(page).to have_content "text-area"
    expect(page).to have_content "checkbox"
    expect(page).to have_content "radio"
    expect(page).to have_content "date"
    expect(page).to have_content "dropdown"
    expect(page).to have_content "url"
    expect(page).to have_content "text"
  end

  it "external user can view all candidates available to them via the candidate select dropdown" do
    page.set_rack_session(:external_user_id => @external_user.id)
    other_candidate = Candidate.create(first_name:"Catherine",
                                       last_name:"The Great",
                                       title:"Greatest Leader of the Russian Empire",
                                       bio:"Most renowned and longest reigning female leader of Russia",
                                       state:"active",
                                       external_user_id:@external_user.id)
    visit external_jobs_path
    click_link "Submit a Candidate!"
    expect(page).to have_content "Catherine"
    expect(page).to have_content "Daniel"
  end

end

