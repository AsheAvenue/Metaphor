class DropDisplayTypeFromArticle < ActiveRecord::Migration
  def change
    remove_column :articles, :display_type
  end
end
