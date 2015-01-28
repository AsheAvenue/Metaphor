class Collection < ActiveRecord::Base
  attr_accessible :name, :slug, :content_type, :pinned_only, :article_type, :category, :flag, :tag, :limit, :order, :pinned_entities_attributes
  
  has_many :pinned_entities, :order => 'pinned_entities.order ASC'
  has_many :entities, :through => :pinned_entities
  
  accepts_nested_attributes_for :pinned_entities
  
  def self.get(slug)
    if items = Rails.cache.read("collection_#{slug}")
      items
    else
      c = Collection.find_by_slug(slug)
      if c
        generated = []
    
        unless c.pinned_only
          c.content_type.capitalize.constantize
            .with_type(c.article_type)
            .with_category(c.category)
            .flagged_as(c.flag)
            .sort_by(c.order)
            .with_limit(c.limit)
            .published
            .each do |a|
              generated << a.current
          end
        end
        
        pinned = []
        c.pinned_entities.each do |e|
          pinned << e.entity.current
        end
        collection = (pinned + generated).uniq
      else
        # return nothing if the collection doesn't exist
        collection = []
      end
      
      Rails.cache.write "collection_#{slug}", collection, :expires_in => 10.minutes
      Rails.cache.write "collection_#{slug}", collection, :expires_in => 10.minutes
      
      collection
      
    end
  end 
  
end
