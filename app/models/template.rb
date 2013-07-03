class Template < ActiveRecord::Base
  attr_accessible :image_url, :name, :slug
  
  has_many :template_components, :dependent => :destroy
  has_many :components, :through => :template_components
  
end
