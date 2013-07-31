class ChangeDisplayNameToName < ActiveRecord::Migration
  def change
    rename_column :users, :display_name, :first_name
    add_column :users, :last_name, :string
  end
end
