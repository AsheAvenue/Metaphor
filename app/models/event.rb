class Event < ActiveRecord::Base
  
  include Metaphor::EntityBase
  
  attr_accessible :date, 
    :event_type, 
    :time, 
    :body
  
  scope :recently_created, order("events.created_at desc")
  scope :recently_updated, order("events.updated_at desc")
    
  scope :sort_by, lambda { |order|
    if order == "newest"
      order("events.created_at DESC")
    elsif order == "oldest"
      order("events.created_at ASC")
    end
  }
  scope :with_event_type, lambda { |event_type|
    where(:event_type => event_type) if event_type != ''
  }
  scope :flagged_as, lambda { |flag| 
    joins(:flags).where("flags.slug = ?", flag) if !flag.empty?
  }
  scope :with_limit, lambda { |l|
    if l && l.is_a?(Integer) && l > 0 
      limit(l)
    end
  }
  
  # GETTING FROM THE FRONTEND
  def self.get(slug)
    event = Event.where(:slug => slug).first
    return nil if !event
    event
  end
  
  
end
