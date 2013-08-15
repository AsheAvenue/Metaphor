class Event < ActiveRecord::Base
  
  include Metaphor::EntityBase
  
  attr_accessible :date, 
    :event_type, 
    :time, 
    :body
  
  has_attached_file :default_image,
    :storage => :s3,
    :bucket => Settings.filepicker.s3.bucket,
    :path => Settings.filepicker.s3.path,
    :s3_credentials => {
      :access_key_id => Settings.filepicker.s3.access_key_id,
      :secret_access_key => Settings.filepicker.s3.secret_access_key
    },
    :styles => Settings.events.image.sizes.to_hash,
    :convert_options => Settings.events.image.convert_options.to_hash
  
  scope :recently_created, order("events.created_at desc")
  scope :recently_updated, order("events.updated_at desc")
    
  scope :sort_by, lambda { |order|
    if order == "newest"
      order("events.created_at DESC")
    elsif order == "oldest"
      order("events.created_at ASC")
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
  
  # GETTING FROM THE FRONTEND
  def self.get(slug)
    event = Event.where(:slug => slug).first
    return nil if !event
    event
  end
  
  
end
