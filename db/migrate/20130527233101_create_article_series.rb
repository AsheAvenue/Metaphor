class CreateArticleSeries < ActiveRecord::Migration
  def change
    create_table :article_series do |t|
      t.integer :article_id
      t.integer :series_id

      t.timestamps
    end
  end
end
