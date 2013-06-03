class Article < ActiveRecord::Base
  attr_accessible :slug, :title, :body, :category_ids, :series_ids, :user_ids, :publish_at, :published, :author_other_name
  
  has_many :article_categories, :dependent => :destroy
  has_many :categories, :through => :article_categories
  has_many :article_series, :dependent => :destroy
  has_many :series, :through => :article_series
  has_many :article_users, :dependent => :destroy
  has_many :users, :through => :article_users
  
  def author
    users ? users.first : nil
  end
    
  def author_name
    author != nil ? author_other_name || author.display_name : nil
  end
  
end
