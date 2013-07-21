class CreateTemplateComponents < ActiveRecord::Migration
  def change
    create_table :template_components, :id => false do |t|
      t.integer :template_id
      t.integer :component_id
      t.integer :order

      t.timestamps
    end
  end
end
