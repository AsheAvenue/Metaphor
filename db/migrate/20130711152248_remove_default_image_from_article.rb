class RemoveDefaultImageFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :default_image
  end
  
  def down
    add_column :articles, :default_image, :string
  end
end
