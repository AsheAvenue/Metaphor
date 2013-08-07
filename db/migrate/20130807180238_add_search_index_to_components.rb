class AddSearchIndexToComponents < ActiveRecord::Migration
  def up
    execute "create index galleries_name on galleries using gin(to_tsvector('english', name))"
    execute "create index images_name on images using gin(to_tsvector('english', name))"
    execute "create index videos_name on videos using gin(to_tsvector('english', name))"
    execute "create index sounds_name on sounds using gin(to_tsvector('english', name))"
  end

  def down
    execute "drop index galleries_name"
    execute "drop index images_name"
    execute "drop index videos_name"
    execute "drop index sounds_name"
  end
end
