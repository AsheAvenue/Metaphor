class Template < ActiveRecord::Base
  attr_accessible :name, :slug, :image, :image_original_filename
    
  attr_accessor :image_original_filename
  
  has_attached_file :image,
      :storage => :s3,
      :bucket => 'metaphor-images',
      :path => "template/:id/:style.:extension",
      :s3_credentials => {
        :access_key_id => 'AKIAJU2Z5ERW6USCRFNQ',
        :secret_access_key => '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'
      },
      :styles => {
        :large => '180x250#',
        :thumb => '90x125#'
      },
      :convert_options => {
        :thumb => "-quality 75 -strip" 
      }
      
  has_many :template_components, :dependent => :destroy
  has_many :components, :through => :template_components
  
end
