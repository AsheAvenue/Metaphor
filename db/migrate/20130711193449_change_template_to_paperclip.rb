class ChangeTemplateToPaperclip < ActiveRecord::Migration
  def up
    remove_column :templates, :image_url
    add_attachment :templates, :image
  end
  
  def down
    add_column :templates, :image_url, :string
    remove_attachment :templates, :image
  end
end
