class CreateMetaphorFlags < ActiveRecord::Migration
  def change
    create_table :metaphor_flags do |t|
      t.string :name
      t.string :slug

      t.timestamps
    end
  end
end
