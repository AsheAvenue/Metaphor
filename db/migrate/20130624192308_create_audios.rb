class CreateAudios < ActiveRecord::Migration
  def change
    create_table :audios do |t|
      t.string :description
      t.string :code
      t.string :length

      t.timestamps
    end
  end
end
