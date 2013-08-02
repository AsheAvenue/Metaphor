class Gallery < ActiveRecord::Base
  attr_accessible :name, :slug
  
  has_many :entity_contents, :as => :entity
  has_many :images, :through => :entity_contents, :source => :content, :source_type => "Image"
           
end
