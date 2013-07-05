class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :gallery_id
      t.string :name
      t.string :slug
      t.string :caption
      t.string :credit
      t.string :image_url

      t.timestamps
    end
  end
end
