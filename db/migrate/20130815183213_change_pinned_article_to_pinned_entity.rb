class ChangePinnedArticleToPinnedEntity < ActiveRecord::Migration
  def up
    rename_table :pinned_articles, :pinned_entities
    rename_column :pinned_entities, :article_id, :entity_id
    add_column :pinned_entities, :entity_type, :string, after: :entity_id
  end
  
  def down
    rename_table :pinned_entities, :pinned_articles 
    rename_column :pinned_articles, :entity_id, :article_id
    drop_column :pinned_articles, :entity_type
  end
  
end
