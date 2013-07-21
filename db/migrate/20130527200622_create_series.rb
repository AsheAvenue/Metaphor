class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.integer :id
      t.string :slug
      t.string :name
      t.timestamps
    end
  end
end
