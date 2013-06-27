class PinnedArticle < ActiveRecord::Base
  attr_accessible :article_id, :collection_id, :order
  belongs_to :collection
  belongs_to :article
end
