class User < ActiveRecord::Base
  has_many :contacts
  validates :username, :format => { with: /[a-z0-9]/i }
  validates :username, length: 3..20
  validates :username, uniqueness: true
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
  validates :email, uniqueness: true
  validates :password, length: 6..20
  has_secure_password
end
