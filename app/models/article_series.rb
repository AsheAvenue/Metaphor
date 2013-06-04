class ArticleSeries < ActiveRecord::Base
  belongs_to :article  
  belongs_to :series
end
