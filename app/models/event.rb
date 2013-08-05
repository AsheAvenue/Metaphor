class Event < ActiveRecord::Base
  attr_accessible :title, 
    :slug, 
    :date, 
    :event_type, 
    :time, 
    :body,
    :tag_list
  
  has_many :related_entities, :as => :entity
  
  acts_as_ordered_taggable
  
end
