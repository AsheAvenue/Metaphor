class ChangeImageToPaperclip < ActiveRecord::Migration
  def up
    remove_column :images, :image_url
    add_attachment :images, :image
  end
  
  def down
    add_column :images, :image_url, :string
    remove_attachment :images, :image
  end
end
