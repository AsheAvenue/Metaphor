class AddPinnedOnlyFlagToCollection < ActiveRecord::Migration
  def change
    add_column :collections, :pinned_only, :boolean
  end
end
