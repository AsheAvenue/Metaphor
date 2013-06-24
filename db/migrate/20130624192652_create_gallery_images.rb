class CreateGalleryImages < ActiveRecord::Migration
  def change
    create_table :gallery_images do |t|
      t.integer :gallery_id
      t.string :title
      t.string :description
      t.string :caption
      t.string :credit
      t.string :image_path

      t.timestamps
    end
  end
end
