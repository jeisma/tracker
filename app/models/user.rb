class User < ActiveRecord::Base
#  attr_accessible :last_name, :first_name, :email, :privileged

  validates :email, presence: true, uniqueness: true
  validates :last_name, :first_name, presence: true, length: {maximum: 45} 
  
  validates :password, length: {minimum: 6}
  before_save { self.email = email.downcase }
  has_secure_password
end
