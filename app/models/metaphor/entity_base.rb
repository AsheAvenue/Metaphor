module Metaphor
  module EntityBase 
    
    def self.included(base)
      base.attr_accessible :slug, 
        :title, 
        :flag_ids, 
        :default_image,
        :default_image_selected,
        :default_image_original_filename,
        :tag_list,
        :legacy_slug,
        :upvotes
        
        base.has_many :entity_flags, :dependent => :destroy, :as => :entity
        base.has_many :flags, :through => :entity_flags

        base.has_many :related_entities, :as => :entity
        
        base.validates_presence_of :title, :slug
        base.validates_uniqueness_of :slug
  
        base.acts_as_ordered_taggable
        
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
    
    def is(flag)
      #checks to see if a flag is true based on the flag sent in
      self.flags.each do |f|
        return true if f.slug == flag
      end
      return false
    end
    
  end
end