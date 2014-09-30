class InhExtContract < ActiveRecord::Base

  belongs_to :inhouse_user
  belongs_to :external_user

end