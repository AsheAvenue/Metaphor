class CreateContentWidgets < ActiveRecord::Migration
  def change
    create_table :content_widgets do |t|
      t.integer :entity_id
      t.integer :content_id
      t.string :entity_type
      t.string :content_type
      t.integer :position

      t.timestamps
    end
  end
end
