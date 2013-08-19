class Gallery < ActiveRecord::Base
  attr_accessible :name, :slug
  
  has_many :entity_contents, :as => :entity
  has_many :images, :through => :entity_contents, :source => :content, :source_type => "Image", :order => 'position ASC'

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
  
  # GETTING FROM THE FRONTEND
  def self.get(slug)
    g = Rails.cache.fetch("gallery_#{slug}") { 
      gallery = Gallery.find_by_slug(:slug => slug).includes(:images).all.first
      item = gallery || nil
      item
    }
    g
  end
  
end
