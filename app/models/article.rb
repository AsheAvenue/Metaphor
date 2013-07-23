class Article < ActiveRecord::Base
  attr_accessible :slug, 
    :title, 
    :summary, 
    :body, 
    :category_ids, 
    :series_ids, 
    :user_ids, 
    :publish_at, 
    :published, 
    :default_image,
    :default_image_selected,
    :default_image_original_filename,
    :author_other_name, 
    :template
  
  attr_accessor :default_image_selected, :default_image_original_filename
    
  has_many :article_categories, :dependent => :destroy
  has_many :categories, :through => :article_categories

  has_many :article_related_parties, :dependent => :destroy
  has_many :related_parties, :through => :article_related_parties

  has_many :article_series, :dependent => :destroy
  has_many :series, :through => :article_series

  has_many :article_flags, :dependent => :destroy
  has_many :flags, :through => :article_flags

  has_many :article_users, :dependent => :destroy

  has_many :users, :through => :article_users
  has_many :content_widgets, :as => :entity

  
  validates_presence_of :title, :slug
  validates_uniqueness_of :slug
  
  scope :newest, order("articles.created_at desc")
  
  has_attached_file :default_image,
      :storage => :s3,
      :bucket => 'metaphor-images',
      :path => "article/:id/default_image/:style.:extension",
      :s3_credentials => {
        :access_key_id => 'AKIAJU2Z5ERW6USCRFNQ',
        :secret_access_key => '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'
      },
      :styles => {
        :large => '640x360>',
        :medium => '320x180>',
        :thumb => '100x100#'
      },
      :convert_options => {
        :thumb => "-quality 75 -strip" 
      }
         
  # convenience methods
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
  
  # TODO: move the following three methods to a helper at some point
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
