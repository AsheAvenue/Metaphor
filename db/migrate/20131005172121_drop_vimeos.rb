class DropVimeos < ActiveRecord::Migration
  def change
    drop_table 'vimeos'
  end
end
