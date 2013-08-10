class Series < ActiveRecord::Base
  attr_accessible :id, :slug, :name
  has_many :series_categories, :dependent => :destroy  
  has_many :series, :through => :series_categories
  
  scope :alphabetical, order("series.name asc")
  
end