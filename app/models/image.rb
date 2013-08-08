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
    :convert_options => Settings.components.image.image.convert_options.to_hash
      

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
  
end
