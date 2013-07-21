class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.string :name
      t.string :slug
      t.string :article_type
      t.string :order

      t.timestamps
    end
  end
end
