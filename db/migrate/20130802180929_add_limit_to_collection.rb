class AddLimitToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :limit, :integer
  end
end
