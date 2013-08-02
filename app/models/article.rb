class Article < ActiveRecord::Base
  attr_accessible :slug, 
    :title, 
    :summary, 
    :body, 
    :category_ids, 
    :series_ids, 
    :flag_ids, 
    :user_ids, 
    :last_published_revision_id,
    :next_published_revision_id, 
    :publish_next_revision_at, 
    :default_image,
    :default_image_selected,
    :default_image_original_filename,
    :author_other_name, 
    :template,
    :tag_list
    
  # attributes used but not saved to the db
  attr_accessor :default_image_selected, :default_image_original_filename
    
  has_many :article_categories, :dependent => :destroy
  has_many :categories, :through => :article_categories

  has_many :article_series, :dependent => :destroy
  has_many :series, :through => :article_series

  has_many :article_users, :dependent => :destroy
  has_many :users, :through => :article_users
  
  has_many :entity_flags, :dependent => :destroy, :as => :entity
  has_many :flags, :through => :entity_flags

  has_many :entity_contents, :as => :entity
  has_many :videos, :through => :entity_contents, :source => :content, :source_type => "Video"
  has_many :sounds, :through => :entity_contents, :source => :content, :source_type => "Sound"
  has_many :images, :through => :entity_contents, :source => :content, :source_type => "Image"
  has_many :galleries, :through => :entity_contents, :source => :content, :source_type => "Gallery"
  has_many :related_entities, :as => :entity
  
  belongs_to :current_version, :class_name => 'Version', :foreign_key => :last_published_revision_id
  
  validates_presence_of :title, :slug
  validates_uniqueness_of :slug
  
  scope :recent, order("articles.created_at desc")
  scope :recently_updated, order("articles.updated_at desc")
  scope :published, where('articles.last_published_revision_id IS NOT NULL')
  scope :with_article_type, lambda { |template|
    where(:template => template) if template != "all_types"
  }
  scope :sort_by, lambda { |order|
    if order == "newest"
      joins(:current_version).order("versions.created_at DESC")
    elsif order == "oldest"
      joins(:current_version).order("versions.created_at ASC")
    end
  }
  scope :with_category, lambda { |category| 
    if category != ''
      joins(:categories).where("categories.id = ?", category)
    end
  }
  scope :with_series, lambda { |series| 
    if series != ''
      joins(:series).where("series.id = ?", series)
    end
  }
  scope :flagged_as, lambda { |flag| 
    if flag != ''
      joins(:flags).where("flags.id = ?", flag)
    end
  }
  
  has_attached_file :default_image,
      :storage => :s3,
      :bucket => Settings.filepicker.s3.bucket,
      :path => Settings.filepicker.s3.path,
      :s3_credentials => {
        :access_key_id => Settings.filepicker.s3.access_key_id,
        :secret_access_key => Settings.filepicker.s3.secret_access_key
      },
      :styles => {
        :large => '640x360>',
        :medium => '320x180>',
        :homepage_list => '457x310>',
        :original_content => '122x155#',
        :thumb => '160x90#'
      },
      :convert_options => {
        :thumb => "-quality 75 -strip" 
      }
       
  has_paper_trail :only => [:title, :body, :summary, :slug],
                  :skip => [:last_published_revision_id, :next_published_revision_id, :publish_next_revision_at]
  
  acts_as_ordered_taggable
  
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
  
  def category_names
    self.categories.collect{|c| c.name}.join(', ')
  end
  
  # TODO: move the following three methods to a helper at some point
  def status 
    if last_published_revision_id
      "published"
    elsif next_published_revision_id
      "scheduled"
    else
      "unscheduled"
    end
  end
  
  def is(flag)
    #checks to see if an article flag is true based on the flag sent in
    flags.each do |f|
      return true if f.slug == flag
    end
    return false
  end
  
  def current
    self.version_at(self.current_version.created_at)
  end
  
  # PUBLISHING
  #
  # This is called by the cron job managed by the Whenever gem
  def self.publish_scheduled_articles
    articles = Article.where('next_published_revision_id IS NOT ? and publish_next_revision_at < ?', nil, DateTime.now)
    articles.each do |article|
      index_to_publish = article.next_published_revision_id
      article.last_published_revision_id = index_to_publish
      article.next_published_revision_id = nil
      article.publish_next_revision_at = nil
      article.save!
    end
  end
  
end
