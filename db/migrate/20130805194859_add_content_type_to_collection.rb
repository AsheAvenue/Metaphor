class AddContentTypeToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :content_type, :string
  end
end
