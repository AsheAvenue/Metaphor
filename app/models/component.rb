class Component < ActiveRecord::Base
  attr_accessible :name, :slug
  
  has_many :template_components, :dependent => :destroy  
  has_many :templates, :through => :template_components
  
end
