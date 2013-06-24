class Video < ActiveRecord::Base
  attr_accessible :autoplay, :code, :description, :height, :video_type, :width
end
