class Series < ActiveRecord::Base
  attr_accessible :id, :slug, :name, :image, :image_original_filename
  attr_accessor :image_selected, :image_original_filename
  
  has_many :series_categories, :dependent => :destroy  
  has_many :series, :through => :series_categories
  
  scope :alphabetical, order("series.name asc")
  
  has_attached_file :image,
    :storage => :s3,
    :bucket => Settings.filepicker.s3.bucket,
    :path => Settings.filepicker.s3.path,
    :s3_credentials => {
      :access_key_id => Settings.filepicker.s3.access_key_id,
      :secret_access_key => Settings.filepicker.s3.secret_access_key
    },
    :styles => Settings.series.image.sizes.to_hash,
    :convert_options => Settings.series.image.convert_options.to_hash, 
    :default_url => "/assets/missing/series/:style.png",
    :keep_old_files => true
       
end