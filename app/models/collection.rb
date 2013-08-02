class Collection < ActiveRecord::Base
  attr_accessible :name, :slug, :article_type, :category, :series, :flag, :tag, :order, :pinned_articles_attributes
  has_many :pinned_articles, :order => 'pinned_articles.order ASC'
  has_many :articles, :through => :pinned_articles, :conditions => "articles.last_published_revision_id IS NOT NULL"
  accepts_nested_attributes_for :pinned_articles
  
  def self.get(slug)
    # get the collection defined by the slug
    c = Collection.find_by_slug(slug)
    if c
      # combine pinned articles with all articles... uniquify
      generated = []
      Article.with_article_type(c.article_type).with_category(c.category).sort_by(c.order).published.all.each do |a|
        generated << a.current
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
