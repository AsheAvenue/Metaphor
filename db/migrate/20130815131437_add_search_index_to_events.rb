class AddSearchIndexToEvents < ActiveRecord::Migration
  def up
    execute "create index events_title on events using gin(to_tsvector('english', title))"
  end

  def down
    execute "drop index events_title"
  end
end
