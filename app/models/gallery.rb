class Gallery < ActiveRecord::Base
  attr_accessible :name, :slug
  
  has_many :entity_contents,
           :as => :entity
           
end
