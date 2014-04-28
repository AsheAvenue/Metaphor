class Site < ActiveRecord::Base
  set_table_name "site"
  attr_accessible :header_image, :header_image_original_filename
  attr_accessor :header_image_selected, :header_image_original_filename
  
  has_attached_file :header_image,
    :storage => :s3,
    :bucket => Settings.filepicker.s3.bucket,
    :path => Settings.filepicker.s3.path,
    :s3_credentials => {
      :access_key_id => Settings.filepicker.s3.access_key_id,
      :secret_access_key => Settings.filepicker.s3.secret_access_key
    },
    :styles => Settings.site.image.sizes.to_hash,
    :convert_options => Settings.site.image.convert_options.to_hash, 
    :default_url => "/assets/missing/site/bg-texture.jpg",
    :keep_old_files => true
  
end
