class AddEndDateAndTimeToEvent < ActiveRecord::Migration
  def change
    add_column :events, :end_date, :datetime
    add_column :events, :end_time, :string
  end
end
