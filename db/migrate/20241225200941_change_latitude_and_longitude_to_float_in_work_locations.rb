class ChangeLatitudeAndLongitudeToFloatInWorkLocations < ActiveRecord::Migration[6.1]
  def change
    change_column :work_locations, :latitude, :float, using: 'latitude::double precision'
    change_column :work_locations, :longitude, :float, using: 'longitude::double precision'
  end
end
