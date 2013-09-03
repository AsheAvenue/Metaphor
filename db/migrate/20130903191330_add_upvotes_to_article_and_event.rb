class AddUpvotesToArticleAndEvent < ActiveRecord::Migration
  def change
    add_column :articles, :upvotes, :integer, :default => 0
    add_column :events, :upvotes, :integer, :default => 0
  end
end
