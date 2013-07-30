class User < ActiveRecord::Base
#  attr_accessible :last_name, :first_name, :email, :privileged
  
  validates :last_name, :first_name, presence: true, length: {maximum: 45} 
  validates :password, presence: true, length: {in: 6..45}

end
