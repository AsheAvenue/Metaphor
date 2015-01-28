class AddHeaderAlertToSite < ActiveRecord::Migration
  def change
    add_column :site, :header_alert, :string, :default => 'Think Different'
  end
end
