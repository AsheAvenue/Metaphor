module Metaphor
  class SocialController < ApplicationController
    def tumblr
      #call out to tumblr through a tumblr gem and get the latest tumblrs
      #make sure to keep the tumblr login info in Settings.yml, which is 
      #where everything is generalized.
    end
  
    def twitter
      #call out to twitter through a twitter gem and get the latest tweets
      #make sure to keep the twitter login info in Settings.yml, which is 
      #where everything is generalized.
    end
  
    def instagram
      #call out to instagram through an instagram gem and get the latest instagrams
      #make sure to keep the instagram login info in Settings.yml, which is 
      #where everything is generalized.
    end
  end
end
