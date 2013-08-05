class Event < ActiveRecord::Base
  attr_accessible :title, 
    :slug, 
    :date, 
    :event_type, 
    :time, 
    :body, 
    :flag_ids,
    :tag_list
  
  has_many :entity_flags, :dependent => :destroy, :as => :entity
  has_many :flags, :through => :entity_flags

  has_many :related_entities, :as => :entity
  
  scope :flagged_as, lambda { |flag| 
    joins(:flags).where("flags.slug = ?", flag) if !flag.empty?
  }
  
  acts_as_ordered_taggable
  
  def is(flag)
    #checks to see if an event flag is true based on the flag sent in
    flags.each do |f|
      return true if f.slug == flag
    end
    return false
  end
  
end
