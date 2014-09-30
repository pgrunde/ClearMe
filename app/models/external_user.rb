class ExternalUser < ActiveRecord::Base
  has_secure_password

  has_many :inhouse_users, through: :inh_ext_contracts
  has_many :inh_ext_contracts, :foreign_key => "ext_user_id"

  validates :email, :username, presence: true
end