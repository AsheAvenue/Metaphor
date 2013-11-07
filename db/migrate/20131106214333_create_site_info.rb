class CreateSiteInfo < ActiveRecord::Migration
  def change
    create_table :site do |t|
      t.timestamps
    end
  end
end
