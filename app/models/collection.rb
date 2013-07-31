class Collection < ActiveRecord::Base
  attr_accessible :article_type, :name, :order, :slug, :pinned_articles_attributes
  has_many :pinned_articles, :order => 'pinned_articles.order ASC'
  accepts_nested_attributes_for :pinned_articles
  
  def get(slug)
    collection = Collection.find_by_slug(slug)
    
    # apply scope based on the article type
    
    # apply scope based on order
    
    # get the actual articles and put them into an array
    
    # get pinned articles and add them to the array
    
    #return the article array
    
  end 
  
end
