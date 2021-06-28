class User < ApplicationRecord
  has_secure_password
  has_one_attached :avatar
  
  validates :email_id, presence: true, uniqueness: true
  validates :password, presence: true
end
