class ChangeCollectionFlagToSlug < ActiveRecord::Migration
  def change
    change_column :collections, :flag, :string
  end
end
