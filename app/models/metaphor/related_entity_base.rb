module Metaphor
  module RelatedEntityBase    

    def self.included(base)
      base.attr_accessible :name, 
        :slug, 
        :default_image,
        :default_image_selected,
        :default_image_original_filename,
        :upvotes
  
      base.has_many :related_entities, :as => :related
      base.has_many :articles, :through => :related_entities, :source => :entity, :source_type => 'Article'
      base.has_many :events, :through => :related_entities, :source => :entity, :source_type => 'Event'
      
      base.scope :recently_created
      base.scope :recently_updated
      base.scope :published
      base.scope :sort_by
      base.scope :with_type
      base.scope :with_category
      base.scope :with_series
      base.scope :flagged_as
      base.scope :with_limit
    
    end
  
    attr_accessor :default_image_selected, :default_image_original_filename
    
    def current
      self
    end

  end
end