class InhouseUser < ActiveRecord::Base
  has_secure_password

  has_many :jobs
  has_many :forms
  has_many :external_users, through: :inh_ext_contracts

  validates :email, :username, presence: true
end