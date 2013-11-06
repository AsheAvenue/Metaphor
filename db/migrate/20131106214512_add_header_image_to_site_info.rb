class AddHeaderImageToSiteInfo < ActiveRecord::Migration
  def self.up
    add_attachment :site_info, :header_image
  end

  def self.down
    remove_attachment :site_info, :header_image
  end
end
