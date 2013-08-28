class Event < ActiveRecord::Base
  
  include Metaphor::EntityBase
  
  attr_accessible :date, 
    :event_type, 
    :time,
    :end_date,
    :end_time,
    :body
  
  validates_presence_of :title, :slug, :date, :event_type
  
  has_attached_file :default_image,
    :storage => :s3,
    :bucket => Settings.filepicker.s3.bucket,
    :path => Settings.filepicker.s3.path,
    :s3_credentials => {
      :access_key_id => Settings.filepicker.s3.access_key_id,
      :secret_access_key => Settings.filepicker.s3.secret_access_key
    },
    :styles => Settings.events.image.sizes.to_hash,
    :convert_options => Settings.events.image.convert_options.to_hash,
    :default_url => "/assets/missing/events/:style.png"
  
  scope :recently_created, order("events.created_at desc")
  scope :recently_updated, order("events.updated_at desc")
    
  scope :sort_by, lambda { |order|
    if order == "newest"
      order("events.date ASC").where("events.date > ?", Date.yesterday)
    elsif order == "oldest"
      order("events.date DESC").where("events.date > ?", Date.yesterday)
    end
  }
  scope :with_type, lambda { |event_type|
    where(:event_type => event_type) if event_type != ''
  }
  scope :flagged_as, lambda { |flag| 
    joins(:flags).where("flags.slug = ?", flag) if !flag.empty?
  }
  scope :with_limit, lambda { |l|
    if l && l.is_a?(Integer) && l > 0 
      limit(l)
    end
  }
  
  def current
    self
  end
  
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
  
  def self.reprocess
    Event.find_each { |entity| entity.default_image.reprocess! }
  end
  
  # GETTING FROM THE FRONTEND
  def self.get(slug)
    event = Rails.cache.fetch("event_#{slug}") { 
      Event.where({:slug => slug}).first
    }
    event
  end
  
end
