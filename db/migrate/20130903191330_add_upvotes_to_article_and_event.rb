class AddUpvotesToArticleAndEvent < ActiveRecord::Migration
  def change
    add_column :articles, :upvotes, :integer, :default => 1
    add_column :events, :upvotes, :integer, :default => 1
  end
end
