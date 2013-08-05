class Event < ActiveRecord::Base
  attr_accessible :title, :slug, :date, :event_type, :time, :body
end
