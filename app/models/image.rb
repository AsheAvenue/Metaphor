class Image < ActiveRecord::Base
  attr_accessible :caption, :credit, :gallery_id, :name, :slug, :image, :image_original_filename
  
  attr_accessor :image_original_filename
  
  has_attached_file :image,
      :storage => :s3,
      :bucket => 'metaphor-images',
      :path => "image/:id/:style.:extension",
      :s3_credentials => {
        :access_key_id => 'AKIAJU2Z5ERW6USCRFNQ',
        :secret_access_key => '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'
      },
      :styles => {
        :extralarge =>    '688x500#',
        :large =>         '550x400#',
        :medium =>        '320x180#',
        :largethumb =>    '200x200#',
        :mediumthumb =>   '138x138#',
        :thumb =>         '64x64#'
      },
      :convert_options => {
        :thumb => "-quality 75 -strip",
        :largethumb => "-quality 75 -strip"
      }
      
end
