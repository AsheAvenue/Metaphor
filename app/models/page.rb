class Page < ActiveRecord::Base
  attr_accessible :content, :name, :slug

  # GETTING FROM THE FRONTEND
  # Pass in a page slug, get the page
  def self.get(slug)
    p = Page.find_by_slug(slug)
    if p
      p
    else
      nil
    end
  end
  
end
