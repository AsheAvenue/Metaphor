class AddAuthorToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :user_id, :integer
    add_column :articles, :author_other_name, :string 
  end
end
