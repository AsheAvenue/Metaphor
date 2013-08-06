module Metaphor
  module RelatedEntityBase    

    def self.included(base)
      base.attr_accessible :name, 
        :slug, 
        :default_image,
        :default_image_selected,
        :default_image_original_filename
  
      base.has_many :related_entities, :as => :related
      base.has_many :articles, :through => :related_entities, :source => :entity, :source_type => 'Article'
      base.has_many :events, :through => :related_entities, :source => :entity, :source_type => 'Event'
    
    end
  
    attr_accessor :default_image_selected, :default_image_original_filename

  end
end