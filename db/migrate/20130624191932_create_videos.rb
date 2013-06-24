class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :description
      t.string :code
      t.boolean :autoplay
      t.integer :height
      t.integer :width
      t.string :video_type

      t.timestamps
    end
  end
end
