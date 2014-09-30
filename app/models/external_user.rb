class ExternalUser < ActiveRecord::Base
  has_secure_password

  has_many :inhouse_users, through: :inh_ext_contracts

  validates :email, :username, presence: true
end