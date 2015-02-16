class TryRemovingDisplayTypeAgain < ActiveRecord::Migration
  def change
    if column_exists? :articles, :display_type
      remove_column :articles, :display_type
    end
  end
end
