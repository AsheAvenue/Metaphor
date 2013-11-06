class CreateSiteInfo < ActiveRecord::Migration
  def change
    create_table :site_info do |t|
      t.timestamps
    end
  end
end
