class InhExtContract < ActiveRecord::Base

  validates_uniqueness_of :inh_user_id, scope: :ext_user_id
  validates_uniqueness_of :ext_user_id, scope: :inh_user_id

  belongs_to :inhouse_user, foreign_key: "inh_user_id"
  belongs_to :external_user, foreign_key: "ext_user_id"

end