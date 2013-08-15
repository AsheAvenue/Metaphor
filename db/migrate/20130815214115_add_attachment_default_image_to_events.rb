class AddAttachmentDefaultImageToEvents < ActiveRecord::Migration
  def self.up
    change_table :events do |t|
      t.attachment :default_image
    end
  end

  def self.down
    drop_attached_file :events, :default_image
  end
end
