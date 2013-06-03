class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :name
      t.string :key
      t.timestamps
    end
    
    create_table :user_roles do |t|
      t.integer :user_id
      t.integer :role_id
      t.timestamps
    end
    
  end
end
