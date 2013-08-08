class Collection < ActiveRecord::Base
  attr_accessible :name, :slug, :content_type, :article_type, :category, :series, :flag, :tag, :limit, :order, :pinned_articles_attributes
  has_many :pinned_articles, :order => 'pinned_articles.order ASC'
  has_many :articles, :through => :pinned_articles, :conditions => "articles.last_published_revision_id IS NOT NULL"
  accepts_nested_attributes_for :pinned_articles
  
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
          generated << a
        end
      pinned = []
      c.articles.each do |a|
        pinned << a.current
      end
      (pinned + generated).uniq
    else
      # return nothing if the collection doesn't exist
      []
    end
  end 
  
end
