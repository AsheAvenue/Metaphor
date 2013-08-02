class Collection < ActiveRecord::Base
  attr_accessible :name, :slug, :article_type, :category, :series, :flag, :tag, :order, :pinned_articles_attributes
  has_many :pinned_articles, :order => 'pinned_articles.order ASC'
  has_many :articles, :through => :pinned_articles
  accepts_nested_attributes_for :pinned_articles
  
  def self.get(slug)
    # get the collection defined by the slug
    c = Collection.find_by_slug(slug)
    # combine pinned articles with all articles... uniquify
    Article.article_type(c.article_type).sort(c.order).category(c.category).published.all.each do |a|
      c.articles << a.current
    end
    c.articles.uniq
  end 
  
end
