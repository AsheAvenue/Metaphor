class DeleteRelatedParty < ActiveRecord::Migration
  def up
    drop_table :related_parties
  end

  def down
    create_table :related_parties do |t|
      t.integer :id
      t.string :name
      t.string :slug
      t.timestamps
    end
  end
end
