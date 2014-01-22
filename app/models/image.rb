class Image < ActiveRecord::Base
  attr_accessible :caption, :credit, :gallery_id, :name, :slug, :image, :image_original_filename
  
  attr_accessor :image_original_filename
  
  has_attached_file :image,
    :storage => :s3,
    :bucket => Settings.filepicker.s3.bucket,
    :path => Settings.filepicker.s3.path,
    :s3_credentials => {
      :access_key_id => Settings.filepicker.s3.access_key_id,
      :secret_access_key => Settings.filepicker.s3.secret_access_key
    },
    :styles => Settings.components.image.image.sizes.to_hash,
    :convert_options => Settings.components.image.image.convert_options.to_hash,
    :keep_old_files => true
      

  include PgSearch
  pg_search_scope :search, 
    against: [:name],
    using: {tsearch: {dictionary: "english"}}

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end
  
  def reprocess(size = nil)
    if size
      self.image.reprocess! size
    else
      self.image.reprocess!
    end
  end
  
  def self.reprocess(size = nil)
    Image.find_each { |image| 
      if size
        image.image.reprocess! size
      else
        image.image.reprocess!
      end
    }
  end
  
  # GETTING FROM THE FRONTEND
  def self.get(slug)
    i = Rails.cache.fetch("image_#{slug}") { 
      image = Image.where(:slug => slug).all.first
      item = image || nil
      item
    }
    i
  end
  
end
