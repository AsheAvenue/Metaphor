class Article < ActiveRecord::Base
  attr_accessible :slug, :title, :body, :category_ids, :series_ids, :user_ids, :publish_at, :published, :author_other_name
  
  has_many :article_categories, :dependent => :destroy
  has_many :categories, :through => :article_categories
  has_many :article_series, :dependent => :destroy
  has_many :series, :through => :article_series
  has_many :article_users, :dependent => :destroy
  has_many :users, :through => :article_users
  
  scope :newest, order("articles.created_at desc")
  
  def author
    users.first
  end
    
  def author_display_name
    if author_other_name != ""
      return author_other_name
    else
      return author.display_name
    end
  end
  
  def status 
    if published
      "Published"
    elsif publish_at
      "Scheduled"
    else
      "Not scheduled"
    end
  end
  
  def status_color
    if published
      "#1abc9c"
    elsif publish_at
      "#f39c12"
    else
      "#c0392b"
    end
  end
  
  def status_class
    if published
      "published"
    elsif publish_at
      "scheduled"
    else
      "not_scheduled"
    end
  end
  
end
