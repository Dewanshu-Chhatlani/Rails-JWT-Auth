class User < ApplicationRecord
  has_secure_password
  
  validates :email_id, presence: true, uniqueness: true
  validates :password, presence: true
end
