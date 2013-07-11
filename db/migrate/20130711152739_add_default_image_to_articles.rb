class AddDefaultImageToArticles < ActiveRecord::Migration
  def self.up
    add_attachment :articles, :default_image
  end

  def self.down
    remove_attachment :articles, :default_image
  end
end
