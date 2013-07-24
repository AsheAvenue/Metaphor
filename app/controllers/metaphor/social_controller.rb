module Metaphor
  class SocialController < ApplicationController
    skip_before_filter :require_login 
    skip_load_and_authorize_resource

    def tumblr
      #call out to tumblr through a tumblr gem and get the latest tumblrs
      #make sure to keep the tumblr login info in Settings.yml, which is 
      #where everything is generalized.
    end
  
    def twitter
      #call out to twitter through a twitter gem and get the latest tweets
      #make sure to keep the twitter login info in Settings.yml, which is 
      #where everything is generalized.

      @tweets = Twitter.user_timeline(Settings.socials.twitter.handle)
      @response = []
      @tweets.each do |t|
        @response << { "tweet" => t.text }
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
        @response << { "caption" => p.caption.text, "images" => p.images }
      end
      render :json => @response.to_json
    end
  end
end
