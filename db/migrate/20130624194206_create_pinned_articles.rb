class CreatePinnedArticles < ActiveRecord::Migration
  def change
    create_table :pinned_articles do |t|
      t.integer :collection_id
      t.integer :article_id
      t.integer :order

      t.timestamps
    end
  end
end
