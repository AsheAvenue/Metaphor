class ArticleRelatedParty < ActiveRecord::Base
  belongs_to :article  
  belongs_to :related_party
end
