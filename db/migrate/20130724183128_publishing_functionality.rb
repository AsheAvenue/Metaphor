class PublishingFunctionality < ActiveRecord::Migration
  def up
    remove_column :articles, :publish_at
    remove_column :articles, :published
    add_column :articles, :last_published_revision_index, :integer
    add_column :articles, :next_published_revision_index, :integer
    add_column :articles, :publish_next_revision_at, :datetime
  end

  def down
    remove_column :articles, :publish_next_revision_at
    remove_column :articles, :next_published_revision_index
    remove_column :articles, :last_published_revision_index
    add_column :articles, :publish_at, :datetime
    add_column :articles, :published, :boolean
  end
end
