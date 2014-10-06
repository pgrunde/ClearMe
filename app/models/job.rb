class Job < ActiveRecord::Base

  has_one :form
  belongs_to :inhouse_user, foreign_key: :inh_user_id

end