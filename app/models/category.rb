class Category < ActiveRecord::Base
  attr_accessible :id, :slug, :name
  has_many :article_categories, :dependent => :destroy  
  has_many :articles, :through => :article_categories
end
