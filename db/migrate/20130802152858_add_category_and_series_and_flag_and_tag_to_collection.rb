class AddCategoryAndSeriesAndFlagAndTagToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :category, :integer
    add_column :collections, :series, :integer
    add_column :collections, :flag, :integer
    add_column :collections, :tag, :integer
  end
end
