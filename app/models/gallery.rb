class Gallery < ActiveRecord::Base
  attr_accessible :name, :slug
  
  has_many :entity_contents, :as => :entity
  has_many :images, :through => :entity_contents, :source => :content, :source_type => "Image"

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
