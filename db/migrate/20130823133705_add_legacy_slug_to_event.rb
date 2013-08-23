class AddLegacySlugToEvent < ActiveRecord::Migration
  def change
    add_column :events, :legacy_slug, :string
  end
end
