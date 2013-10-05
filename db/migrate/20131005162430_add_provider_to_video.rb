class AddProviderToVideo < ActiveRecord::Migration
  def change
    add_column :videos, :provider, :string, :default => 'youtube'
  end
end
