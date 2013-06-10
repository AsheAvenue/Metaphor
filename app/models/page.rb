class Page < ActiveRecord::Base
  attr_accessible :content, :name, :slug
  
  def to_param 
    slug
  end

end
