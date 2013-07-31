class Collection < ActiveRecord::Base
  attr_accessible :article_type, :name, :order, :slug, :pinned_articles_attributes
  has_many :pinned_articles, :order => 'pinned_articles.order ASC'
  accepts_nested_attributes_for :pinned_articles
  
  def get_articles
    articles = Article.send(self.order)
    articles2 = []
    self.pinned_articles.each do |pa|
      articles2 << pa.article
    end
    
    articles = articles2 + articles
  end 
  
end
