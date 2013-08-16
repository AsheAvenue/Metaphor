module Metaphor
  class SocialController < ApplicationController
    skip_before_filter :require_login 
    skip_load_and_authorize_resource

    layout 'metaphor/metaphor'
    
    def tumblr
      #call out to tumblr through a tumblr gem and get the latest tumblrs
      #make sure to keep the tumblr login info in Settings.yml, which is 
      #where everything is generalized.

      #tumblr currently just pulls from an RSS feed
      require 'feedzirra'
      @rss_url = "http://" + Settings.socials.tumblr.url + "/rss"
      @feed = Feedzirra::Feed.fetch_and_parse(@rss_url)
      @response = []
      @feed.entries.each do |f|
        @response << { "title"        => f.title,
                       "url"          => f.url,
                       "summary"      => f.summary,
                       "first_image"  => Nokogiri::HTML.fragment(f.summary).at_css('img')['src']
                     }
      end
      render :json => @response.to_json 
    end
  
    def twitter
      #call out to twitter through a twitter gem and get the latest tweets
      #make sure to keep the twitter login info in Settings.yml, which is 
      #where everything is generalized.

      require 'rinku'
      @tweets = Twitter.user_timeline(Settings.socials.twitter.handle)
      @response = []
      @tweets.each do |t|
        @response << { "tweet" => Rinku.auto_link(t.text, :all, 'target="_blank"') }
      end
      render :json => @response.to_json
    end
  
    def instagram
      #call out to instagram through an instagram gem and get the latest instagrams
      #make sure to keep the instagram login info in Settings.yml, which is 
      #where everything is generalized.

      photos = Instagram.tag_recent_media(Settings.socials.instagram.hashtag)
      @response = []
      photos.each do |p|
        @response << { "caption" => p.caption.text, "images" => p.images, "url" => p.link  }
      end
      render :json => @response.to_json
    end
  end
end
