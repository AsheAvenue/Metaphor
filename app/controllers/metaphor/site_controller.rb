module Metaphor
  class SiteController < MetaphorController

    layout 'metaphor/metaphor'
    
    def show
      @site = Site.all.first
      if !@site
        @site = Site.new
        @site.save!
      end
    end
  
    def update
      @site = Site.all.first
      if !@site
        @site = Site.new
        @site.save!
      end
    
      # Open the url that's been returned by Filepicker.
      # Then remove the header_image from params so it doesn't get updated 
      # via update_attributes, which will cause a validation error
      url = params[:site][:header_image]
      original_filename = params[:site][:header_image_original_filename]
      @site.header_image = open(url)
      @site.header_image.instance_write(:file_name, original_filename)
      params[:site].delete :header_image
    
      # Proceed to update the object accordingly
      if @site.save
        flash[:alert] = "Site successfully updated"
      end
      
      # Clear the cache
      Rails.cache.delete("site_info")
      
      # Redirect
      redirect_to site_path
    end
  
  end

end