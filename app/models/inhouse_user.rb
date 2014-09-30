class InhouseUser < ActiveRecord::Base
  has_secure_password

  has_many :jobs
  has_many :forms

  validates :email, :username, presence: true
end