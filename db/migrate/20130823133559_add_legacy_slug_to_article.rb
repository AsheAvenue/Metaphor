class AddLegacySlugToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :legacy_slug, :string
  end
end
