class CreateArticleFlags < ActiveRecord::Migration
  def change
    create_table :article_flags do |t|
      t.integer :article_id
      t.integer :flag_id

      t.timestamps
    end
  end
end
