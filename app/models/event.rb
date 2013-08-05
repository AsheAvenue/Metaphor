class Event < ActiveRecord::Base
  attr_accessible :title, :slug, :date, :type, :time, :body
end
