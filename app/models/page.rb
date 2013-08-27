class Page < ActiveRecord::Base
  attr_accessible :content, :name, :slug

  # GETTING FROM THE FRONTEND
  # Pass in a page slug, get the page
  def self.get(slug)
    if page = Rails.cache.read("page_#{slug}")
      page
    else
      p = Page.find_by_slug(slug)
      if p
        Rails.cache.write "page_#{slug}", p
        p
      else
        nil
      end
    end
  end
  
end
