class InhouseUser < ActiveRecord::Base
  has_secure_password

  has_many :jobs, foreign_key: :inh_user_id
  has_many :forms
  has_many :external_users, through: :inh_ext_contracts
  has_many :inh_ext_contracts, :foreign_key => "inh_user_id"

  validates :email, :username, presence: true
end