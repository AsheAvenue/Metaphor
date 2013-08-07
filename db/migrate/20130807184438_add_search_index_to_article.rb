class AddSearchIndexToArticle < ActiveRecord::Migration
  def up
    execute "create index articles_title on articles using gin(to_tsvector('english', title))"
  end

  def down
    execute "drop index articles_title"
  end
  
end
