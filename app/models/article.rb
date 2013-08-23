class Article < ActiveRecord::Base
  
  include Metaphor::EntityBase
  
  attr_accessible :summary, 
    :body, 
    :category_ids, 
    :series_ids, 
    :user_ids, 
    :last_published_revision_id,
    :next_published_revision_id, 
    :publish_next_revision_at, 
    :author_other_name, 
    :template
    
  default_scope includes(:categories, :series, :flags, :galleries, :videos, :sounds, :images)
    
  has_many :article_categories, :dependent => :destroy
  has_many :categories, :through => :article_categories

  has_many :article_series, :dependent => :destroy
  has_many :series, :through => :article_series

  has_many :article_users, :dependent => :destroy
  has_many :users, :through => :article_users
  
  has_many :entity_contents, :as => :entity
  has_many :videos, :through => :entity_contents, :source => :content, :source_type => "Video", :order => 'position ASC'
  has_many :sounds, :through => :entity_contents, :source => :content, :source_type => "Sound", :order => 'position ASC'
  has_many :images, :through => :entity_contents, :source => :content, :source_type => "Image", :order => 'position ASC'
  has_many :galleries, :through => :entity_contents, :source => :content, :source_type => "Gallery", :order => 'position ASC'
  
  belongs_to :current_version, :class_name => 'Version', :foreign_key => :last_published_revision_id
  
  scope :recently_created, order("articles.created_at desc")
  scope :recently_updated, order("articles.updated_at desc")
  scope :published, where('articles.last_published_revision_id IS NOT NULL')
  scope :sort_by, lambda { |order|
    if order == "newest"
      joins(:current_version).order("versions.created_at DESC")
    elsif order == "oldest"
      joins(:current_version).order("versions.created_at ASC")
    end
  }
  scope :with_type, lambda { |template|
    where(:template => template) if template != "all_types"
  }
  scope :with_category, lambda { |category|
    joins(:categories).where("categories.id = ?", category) if category
  }
  scope :with_series, lambda { |series| 
    joins(:series).where("series.id = ?", series) if series
  }
  scope :flagged_as, lambda { |flag| 
    joins(:flags).where(:flags => {:slug => flag }) if !flag.empty?
  }
  scope :with_limit, lambda { |l|
    if l && l.is_a?(Integer) && l > 0 
      limit(l)
    end
  }
  scope :without, lambda { |id| 
    where("articles.id <> ? ", id) if id
  }
  
  has_attached_file :default_image,
    :storage => :s3,
    :bucket => Settings.filepicker.s3.bucket,
    :path => Settings.filepicker.s3.path,
    :s3_credentials => {
      :access_key_id => Settings.filepicker.s3.access_key_id,
      :secret_access_key => Settings.filepicker.s3.secret_access_key
    },
    :styles => Settings.articles.image.sizes.to_hash,
    :convert_options => Settings.articles.image.convert_options.to_hash, 
    :default_url => "/assets/missing/articles/:style.png"
       
  has_paper_trail :only => [:title, :body, :summary, :slug],
                  :skip => [:last_published_revision_id, :next_published_revision_id, :publish_next_revision_at]
  
  include PgSearch
  pg_search_scope :search, 
    against: [:title],
    using: {tsearch: {dictionary: "english"}}

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
  
  # convenience methods
  def author
    users.first
  end
    
  def author_display_name
    if author_other_name != ""
      return author_other_name
    else
      if author
        return author.display_name
      else
        return ""
      end
    end
  end
  
  def next
    Rails.cache.fetch("article_#{self.id}_next") {
      a = Article.where("id > ?", self.id).published.order("id ASC").limit(1).first
      a = a.current if a
    }
  end

  def previous
    Rails.cache.fetch("article_#{self.id}_previous") {
      a = Article.where("id < ?", self.id).published.order("id DESC").limit(1).first
      a = a.current if a
    }
  end
  
  def category_names
    self.categories.collect{|c| c.name}.join(', ')
  end
  
  def series_names
    self.series.collect{|c| c.name}.join(', ')
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
  
  def current
    self.current_version ? self.version_at(self.current_version.created_at) : self
  end
  
  def self.reprocess
    Article.find_each { |entity| entity.default_image.reprocess! }
  end
  
  # GETTING FROM THE FRONTEND
  def self.get(slug)
    a = Rails.cache.fetch("article_#{slug}") { 
      article = Article.where(:slug => slug).includes(:artists, :producers, :directors, :images, :galleries, :sounds, :videos).published.all.first
      item = (article == nil) ? nil : article.current
      item
    }
    a
  end
  
  def self.get_by_legacy_slug(legacy_slug)
    article = Article.where(:legacy_slug => legacy_slug).first
    article
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
