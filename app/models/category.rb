class Category < ActiveRecord::Base
  attr_accessible :id, :slug, :name
  has_many :article_categories, :dependent => :destroy  
  has_many :articles, :through => :article_categories
  
  validates_presence_of :slug, :name
  
  
  # GETTING FROM THE FRONTEND
  # Pass in a category slug, get a list of articles
  def self.get(slug)
    c = Category.find_by_slug(slug)
    if c
      Article.with_category(c.id).published.sort_by('newest').all
    else
      []
    end
  end
  
end
