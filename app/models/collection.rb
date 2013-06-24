class Collection < ActiveRecord::Base
  attr_accessible :article_type, :name, :order, :slug, :pinned_articles_attributes
  has_many :pinned_articles
  accepts_nested_attributes_for :pinned_articles
end