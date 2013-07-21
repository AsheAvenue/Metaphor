class AddDefaultImageToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :default_image, :string
  end
end
