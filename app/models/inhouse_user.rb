class InhouseUser < ActiveRecord::Base
  has_secure_password

  validates :email, :username, presence: true
end