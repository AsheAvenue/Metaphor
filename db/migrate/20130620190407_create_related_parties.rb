class CreateRelatedParties < ActiveRecord::Migration
  def change
    create_table :related_parties do |t|
      t.integer :id
      t.string :name
      t.string :slug
      t.timestamps
    end
  end
end
