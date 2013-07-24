module PaperTrail
  class Version < ActiveRecord::Base
    attr_accessible :user_display_name
  end
end