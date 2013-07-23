class Flag < ActiveRecord::Base
  attr_accessible :name, :slug
  
  has_many :article_flags, :dependent => :destroy  
  has_many :articles, :through => :article_flags
  
end