class CreateMetaphorEvents < ActiveRecord::Migration
  def change
    create_table :metaphor_events do |t|
      t.string :title
      t.string :slug
      t.datetime :date
      t.string :type
      t.string :time
      t.text :body

      t.timestamps
    end
  end
end
