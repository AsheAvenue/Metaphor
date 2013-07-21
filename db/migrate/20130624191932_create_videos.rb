class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :name
      t.string :slug
      t.string :code

      t.timestamps
    end
  end
end
