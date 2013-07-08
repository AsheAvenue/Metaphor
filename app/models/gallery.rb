class Gallery < ActiveRecord::Base
  attr_accessible :name, :slug
  
  has_many :content_widgets,
           :as => :entity
           
end
