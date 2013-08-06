class Template < ActiveRecord::Base
  attr_accessible :name, :slug, :image, :image_original_filename
    
  attr_accessor :image_original_filename
  
  has_attached_file :image,
      :storage => :s3,
      :bucket => Settings.filepicker.s3.bucket,
      :path => Settings.filepicker.s3.path,
      :s3_credentials => {
        :access_key_id => Settings.filepicker.s3.access_key_id,
        :secret_access_key => Settings.filepicker.s3.secret_access_key
      },
      :styles => Settings.templates.image.sizes.to_hash,
      :convert_options => Settings.templates.image.convert_options.to_hash
      
  has_many :template_components, :dependent => :destroy
  has_many :components, :through => :template_components
  
end
