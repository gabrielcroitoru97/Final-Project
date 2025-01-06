class AddDailyOpeningClosingTimesToWorkLocations < ActiveRecord::Migration[6.1]
  def change
    add_column :work_locations, :monday_opening, :time
    add_column :work_locations, :monday_closing, :time
    add_column :work_locations, :tuesday_opening, :time
    add_column :work_locations, :tuesday_closing, :time
    add_column :work_locations, :wednesday_opening, :time
    add_column :work_locations, :wednesday_closing, :time
    add_column :work_locations, :thursday_opening, :time
    add_column :work_locations, :thursday_closing, :time
    add_column :work_locations, :friday_opening, :time
    add_column :work_locations, :friday_closing, :time
    add_column :work_locations, :saturday_opening, :time
    add_column :work_locations, :saturday_closing, :time
    add_column :work_locations, :sunday_opening, :time
    add_column :work_locations, :sunday_closing, :time

    # Optional: Remove old columns if no longer needed
    remove_column :work_locations, :weekday_opening, :time
    remove_column :work_locations, :weekday_closing, :time
    remove_column :work_locations, :weekend_opening, :time
    remove_column :work_locations, :weekend_closing, :time
  end
end
