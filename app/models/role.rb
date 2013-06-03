class Role < ActiveRecord::Base
  attr_accessible :key, :name
  
  scope :alphabetical, order("roles.name asc")
  
end
