class AddImageToSeries < ActiveRecord::Migration
  def self.up
    add_attachment :series, :image
  end

  def self.down
    remove_attachment :series, :image
  end
end
