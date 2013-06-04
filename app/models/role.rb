class Role < ActiveRecord::Base
  attr_accessible :key, :name
  
  scope :alphabetical, order("roles.name asc")
  
  has_many :user_roles, :dependent => :destroy
  has_many :users, :through => :user_roles
  
end
