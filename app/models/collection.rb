class Collection < ActiveRecord::Base
  attr_accessible :name, :slug, :content_type, :article_type, :category, :series, :flag, :tag, :limit, :order, :pinned_entities_attributes
  
  has_many :pinned_entities, :order => 'pinned_entities.order ASC'
  has_many :entities, :through => :pinned_entities
  
  accepts_nested_attributes_for :pinned_entities
  
  def self.get(slug)
    # get the collection defined by the slug
    c = Collection.find_by_slug(slug)
    if c
      # combine pinned articles with all articles... uniquify
      generated = []
      
      c.content_type.capitalize.constantize
        .with_type(c.article_type)
        .with_category(c.category)
        .with_series(c.series)
        .flagged_as(c.flag)
        .sort_by(c.order)
        .with_limit(c.limit)
        .published
        .all.each do |a|
          generated << a.current
        end
      pinned = []
      c.pinned_entities.each do |e|
        pinned << e.entity.current
      end
      (pinned + generated).uniq
    else
      # return nothing if the collection doesn't exist
      []
    end
  end 
  
end
