class AddCategoryAndSeriesAndFlagAndTagToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :category, :string
    add_column :collections, :series, :string
    add_column :collections, :flag, :string
    add_column :collections, :tag, :string
  end
end
