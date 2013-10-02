class CreateVimeos < ActiveRecord::Migration
  def change
    create_table :vimeos do |t|
      t.string :name
      t.string :slug
      t.string :code

      t.timestamps
    end
  end
end
