class Image < ActiveRecord::Base
  attr_accessible :caption, :credit, :gallery_id, :name, :slug, :image_url
  
  belongs_to :gallery
end
