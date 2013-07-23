module Metaphor
  class ArticleFlag < ActiveRecord::Base
    attr_accessible :article_id, :flag_id
  end
end
