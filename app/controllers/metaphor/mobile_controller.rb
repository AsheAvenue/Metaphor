require "open-uri"

module Metaphor
  class MobileController < MetaphorController
    
    skip_load_and_authorize_resource
    
    layout 'metaphor/mobile'
    
    before_filter :require_login, :except => :vote
    
    def index
      if Rails.env.production? && Settings.admin.redirect_admin_to_separate_admin_app && request.subdomains.first != Settings.admin.subdomain
        redirect_to Settings.admin.admin_url
      else
        if params[:message]
          @message = params[:message]
        end
      end
      
    end
    
    def image
      @article = Article.new
    end
    
    def image_save
      @article = Article.new
      @article.template = 'simpleimage'
      @article.body = params[:article][:body]
      
      if params[:article][:title] != ''
        @article.title = params[:article][:title]
        @article.slug = ensure_valid_slug(params[:article][:slug])
      else
        @article.title = "image-#{Time.now.to_i}"
        @article.slug = @article.title
      end
      
      if params[:article][:default_image]
        @article.default_image = params[:article][:default_image]

        if @article.save!
          if publish(@article)
            @result = 'success'
            update_article_cache(@article)
            redirect_to '/admin/mobile?message=Image successfully posted.'
          else
            @result = 'failure'
            render :image
          end
        else
          @result = 'failure'
          render :image
        end
      else
        @result = 'error'
        render :image
      end  
    end
    
    def sound
      @article = Article.new
    end
      
    def sound_save
      @article = Article.new
      @article.template = 'simplesound'
      @article.body = params[:article][:body]
      
      if params[:article][:title] != ''
        @article.title = params[:article][:title]
        @article.slug = ensure_valid_slug(params[:article][:slug])
      else
        @article.title = "sound-#{Time.now.to_i}"
        @article.slug = @article.title
      end
      
      if params[:soundcloud_url] != ''
        
        # Add the sound to the content
        t = Template.find_by_slug(@article.template)
        position = t.get_first_component_position('sound')
        if position != nil
          s = Sound.new
          s.code = 166699874
          s.name = @article.title
          s.slug = "#{@article.slug}-sound"
          s.save!

          # add the sound object as a widget to the entity contents in the position saved above
          widget = EntityContent.new
          widget.entity = @article
          widget.content = s
          widget.position = position
          widget.save!    
        end
        
        if @article.save!
          if publish(@article)
            @result = 'success'
            update_article_cache(@article)
            redirect_to '/admin/mobile?message=Sound successfully posted.'
          else
            @result = 'failure'
            render :sound
          end
        else
          @result = 'failure'
          render :sound
        end
      else
        @result = 'error'
        render :sound
      end  
    end
      
      
    private
    
      def update_article_cache(article)
        Rails.cache.delete("article_#{article.slug}")
      end
      
      def ensure_valid_slug(slug)
        if Article.where(:slug => slug).count > 0
          ensure_valid_slug("#{slug}-1")
        else
          slug
        end
      end
      
      def publish(article)
        article.last_published_revision_id = article.versions.last.id
        article.next_published_revision_id = nil 
        article.publish_next_revision_at = nil 
        article.save!
      end
    
  end
end
