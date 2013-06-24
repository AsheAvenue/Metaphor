class GalleryImage < ActiveRecord::Base
  attr_accessible :caption, :credit, :description, :gallery_id, :title, :image_path
  
  belongs_to :gallery
end
