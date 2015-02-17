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
        @article.title = "simple-image-#{Time.now.to_i}"
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
    
    def tweet
      @article = Article.new
    end
    
    def tweet_save
      @article = Article.new
      @article.template = 'simpletweet'
      @article.title = "simple-tweet-#{Time.now.to_i}"
      @article.slug = @article.title
      
      # Call twitter and get an embed link
      begin
        @url = params[:url]
        twitter_client = Twitter::REST::Client.new do |config|
          config.consumer_key        = Settings.twitter.consumer_key
          config.consumer_secret     = Settings.twitter.consumer_secret
          config.access_token        = Settings.twitter.access_token
          config.access_token_secret = Settings.twitter.access_token_secret
        end
        
        oembed = twitter_client.oembed(@url)
        @article.body = oembed.html
      
        if @article.body != '' 
          if @article.save!
            if publish(@article)
              @result = 'success'
              update_article_cache(@article)
              redirect_to '/admin/mobile?message=Tweet successfully posted.'
            else
              @result = 'failure'
              render :tweet
            end
          else
            @result = 'failure'
            render :tweet
          end
        else
          @result = 'error'
          render :tweet
        end  
      rescue
        @result = 'error'
        render :tweet
      end
    end
    
    def video
      @article = Article.new
    end
    
    def video_save
      @article = Article.new
      @article.template = 'simplevideo'
      @article.title = "simple-video-#{Time.now.to_i}"
      @article.slug = @article.title
      
      # Call twitter and get an embed link
      begin
        @url = params[:url]
        @video_type = params[:video_type]
        
        # Get the code
        if @video_type == 'vine'
          code = @url.rpartition('/v/').last
        elsif @video_type == 'youtube'
          code = @url.rpartition('/').last
        end
        
        # Get the template so we can get the position of the video object
        t = Template.find_by_slug(@article.template)
        position = t.get_first_component_position('video')
        
        # Create the video and the content
        v = Video.new
        v.name = @article.title
        v.slug = @article.title
        v.code = code
        v.provider = @video_type
        v.save!
        
        # add the video object as a widget to the entity contents in the position saved above
        widget = EntityContent.new
        widget.entity = @article
        widget.content = v
        widget.position = position
        widget.save! 
        
        if @article.save!
          if publish(@article)
            @result = 'success'
            update_article_cache(@article)
            redirect_to '/admin/mobile?message=Video successfully posted.'
          else
            @result = 'failure'
            render :video
          end
        else
          @result = 'failure'
          render :video
        end
      rescue
        @result = 'error'
        render :video
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
        @article.title = "simple-sound-#{Time.now.to_i}"
        @article.slug = @article.title
      end
      
      if params[:soundcloud_url] != ''
        
        # Call the Soundcloud oEmbed service and get the code 
        begin
          json_as_text = open("http://soundcloud.com/oembed?url=#{params[:soundcloud_url]}").read
          right_side = json_as_text.rpartition('tracks%2F').last
          track_number = right_side.partition('&amp').first
        
          # Add the sound to the content
          t = Template.find_by_slug(@article.template)
          position = t.get_first_component_position('sound')
          if position != nil
            s = Sound.new
            s.code = track_number
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
            puts "|||||||||||||||||||||||||"
            puts @article.errors
            puts "|||||||||||||||||||||||||"
            @result = 'failure'
            render :sound
          end
        rescue
          @result = 'error'
          render :sound
        end
      else
        @result = 'error'
        render :sound
      end  
    end
       
    def quote
      @article = Article.new
    end
    
    def quote_save
      @article = Article.new
      @article.template = 'simplequote'
      
      @quote = params[:quote]
      @source = params[:source]
      @link = params[:link]
      
      @article.body = "#{@quote}|||#{@source}|||#{@link}"
      @article.title = "simple-quote-#{Time.now.to_i}"
      @article.slug = @article.title
      
      if @quote
        if @article.save!
          if publish(@article)
            @result = 'success'
            update_article_cache(@article)
            redirect_to '/admin/mobile?message=Quote successfully posted.'
          else
            @result = 'failure'
            render :quote
          end
        else
          @result = 'failure'
          render :quote
        end
      else
        @result = 'error'
        render :quote
      end  
    end
       
    def link
      @article = Article.new
    end
    
    def link_save
      @article = Article.new
      @article.template = 'simplelink'
      @article.title = "simple-link-#{Time.now.to_i}"
      @article.slug = @article.title
      
      @text = params[:text]
      @url = params[:url]
      
      @article.body = "#{@text}|||#{@url}"
      
      if @text && @text != '' && @url && @url != '' 
        if @article.save!
          if publish(@article)
            @result = 'success'
            update_article_cache(@article)
            redirect_to '/admin/mobile?message=Link successfully posted.'
          else
            @result = 'failure'
            render :link
          end
        else
          @result = 'failure'
          render :link
        end
      else
        @result = 'error'
        render :link
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
