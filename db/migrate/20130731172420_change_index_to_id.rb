class ChangeIndexToId < ActiveRecord::Migration
  def change
    rename_column :articles, :next_published_revision_index, :next_published_revision_id
    rename_column :articles, :last_published_revision_index, :last_published_revision_id
  end
end
