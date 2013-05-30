class AddPublishAtToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :publish_at, :datetime
  end
end
