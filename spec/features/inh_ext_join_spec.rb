require 'rails_helper'
require 'capybara/rails'


describe "in house users can search for existing recruitment firms" do

  it "in house user can view a list of external recruiters" do
    inhouse_user = InhouseUser.create(username: "kipperton",
                                      email: "kipper@example.com",
                                      password_digest: "password")
    external_user = ExternalUser.create(username: "nora",
                                       email:"nora@example.com",
                                       password_digest: "password")
    page.set_rack_session(:inhouse_user_id => inhouse_user.id)
    visit
  end

end