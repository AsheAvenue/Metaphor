class Video < ActiveRecord::Base
  attr_accessible :autoplay, :code, :description, :height, :video_type, :width
  
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
