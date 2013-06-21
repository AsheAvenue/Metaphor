class RelatedParty < ActiveRecord::Base
  attr_accessible :name, :slug
  has_many :article_related_parties, :dependent => :destroy  
  has_many :articles, :through => :article_related_parties
end
