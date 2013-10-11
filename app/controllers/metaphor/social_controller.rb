module Metaphor
  class SocialController < MetaphorController
    skip_before_filter :require_login 
    skip_load_and_authorize_resource

    caches_page :tumblr, :twitter, :instagram
    
    def tumblr
      #call out to tumblr through a tumblr gem and get the latest tumblrs
      #make sure to keep the tumblr login info in Settings.yml, which is 
      #where everything is generalized.

      #tumblr currently just pulls from an RSS feed
      require 'feedzirra'
      @rss_url = "http://" + Settings.socials.tumblr.url + "/rss"
      @response = Rails.cache.fetch("social_tumblr") {
        @feed = Feedzirra::Feed.fetch_and_parse(@rss_url)
        items = []
        @feed.entries.each do |f|
          if f.summary.include? 'img'
            items << { 
              "title"        => f.title,
              "url"          => f.url,
              "summary"      => f.summary,
              "first_image"  => Nokogiri::HTML.fragment(f.summary).at_css('img')['src']
            }
          end
        end
        items
      }
      render :json => @response.to_json 
    end
  
    def twitter
      #call out to twitter through a twitter gem and get the latest tweets
      #make sure to keep the twitter login info in Settings.yml, which is 
      #where everything is generalized.

      require 'rinku'
      @response = Rails.cache.fetch("social_twitter", :expires_in => 15.minutes) {
        @tweets = Twitter.user_timeline(Settings.socials.twitter.handle)
        items = []
        @tweets.each do |t|
          items << { "tweet" => Rinku.auto_link(t.text, :all, 'target="_blank"') }
        end
        items
      }
      render :json => @response.to_json
    end
  
    def instagram
      #call out to instagram through an instagram gem and get the latest instagrams
      #make sure to keep the instagram login info in Settings.yml, which is 
      #where everything is generalized.

      @response = Rails.cache.fetch("social_instagram", :expires_in => 15.minutes) {
        # Instagram.configure do |config|
        #   config.client_id = Settings.socials.instagram.client_id
        #   config.access_token = Settings.socials.instagram.access_token
        # end
        # 
        # photos = Instagram.user_recent_media(Settings.socials.instagram.user_id)
        photos = Instagram.tag_recent_media(Settings.socials.instagram.hashtag)
        items = []
        photos.each do |p|
          items << { "images" => p.images, "url" => p.link  }
        end
        items
      }
      render :json => @response.to_json
    end
  end
end
