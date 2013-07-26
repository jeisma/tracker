class User < ActiveRecord::Base
  attr_accessible :last_name, :first_name, :email, :privileged
  
  validates :presence => :last_name, :first_name, :email, :password
            :length => :name = 45
	    :length => :password = 45
	    :length => :email = 100
            
            
end
