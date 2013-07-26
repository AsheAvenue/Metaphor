class RenameContentWidgetsToEntityContents < ActiveRecord::Migration
  def up
    rename_table :content_widgets, :entity_contents
  end

  def down
    rename_table :entity_contents, :content_widgets
  end
end