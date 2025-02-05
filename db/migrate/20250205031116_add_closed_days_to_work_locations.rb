class AddClosedDaysToWorkLocations < ActiveRecord::Migration[7.1]
  def change
    add_column :work_locations, :monday_closed, :boolean, default: false
    add_column :work_locations, :tuesday_closed, :boolean, default: false
    add_column :work_locations, :wednesday_closed, :boolean, default: false
    add_column :work_locations, :thursday_closed, :boolean, default: false
    add_column :work_locations, :friday_closed, :boolean, default: false
    add_column :work_locations, :saturday_closed, :boolean, default: false
    add_column :work_locations, :sunday_closed, :boolean, default: false
  end
end
