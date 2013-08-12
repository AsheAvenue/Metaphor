module Metaphor
  module UrlHelper
  
    def frontend_url(template, slug)
      if template == "text"
        "/read/#{slug}"
      elsif template == "gallery" 
        "/view/#{slug}"
      elsif template == "video" 
        "/watch/#{slug}"
      elsif template == "sound" 
        "/listen/#{slug}"
      end
    end 
  
  end
end