class AddDisplayTypeToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :display_type, :string, :default => 'regular'
  end
end
