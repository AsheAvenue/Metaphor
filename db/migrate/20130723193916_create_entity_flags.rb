class CreateEntityFlags < ActiveRecord::Migration
  def change
    create_table :entity_flags do |t|
      t.references :flaggable, polymorphic: true
      t.integer :flag_id
      t.timestamps
    end
  end
end
