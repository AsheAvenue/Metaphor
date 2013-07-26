class CreateMetaphorRelatedEntities < ActiveRecord::Migration
  def change
    create_table :metaphor_related_entities do |t|
      t.integer :entity_id
      t.integer :related_id
      t.string :entity_type
      t.string :related_type

      t.timestamps
    end
  end
end
