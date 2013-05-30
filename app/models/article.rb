class Article < ActiveRecord::Base
  attr_accessible :slug, :title, :body, :category_ids, :series_ids, :publish_at, :published
  
  has_many :article_categories, :dependent => :destroy
  has_many :categories, :through => :article_categories
  has_many :article_series, :dependent => :destroy
  has_many :series, :through => :article_series
end
