class Collection < ActiveRecord::Base
  attr_accessible :article_type, :name, :order, :slug, :pinned_articles_attributes
  has_many :pinned_articles, :order => 'pinned_articles.order ASC'
  accepts_nested_attributes_for :pinned_articles
  
  def self.get(slug)
    
    # get the collection defined by the slug
    c = Collection.find_by_slug(slug)
    
    # get the articles according to the scopes
    generated = Article.article_type(c.article_type).sort(c.order).published.all
    
    # hold the pinned articles
    pinned = []
    
    # loop through pinned articles and store them
    c.pinned_articles.each do |pa|
      pinned << pa.article
    end

    articles = pinned + generated
    
    # loop through all articles and remove duplicates
    # also get the current version
    ids_found = []
    articles_to_be_returned = []
    articles.each do |article|
      if !ids_found.include? article.id
        ids_found << article.id
        articles_to_be_returned << article.current
      end
    end
    
    #return the articles
    articles_to_be_returned
    
  end 
  
end
