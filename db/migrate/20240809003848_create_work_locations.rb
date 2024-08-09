class CreateWorkLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :work_locations do |t|
      t.integer :location_type_id
      t.integer :wifi_speed
      t.string :address
      t.time :weekday_opening
      t.time :weekend_opening
      t.time :weekday_closing
      t.time :weekend_closing
      t.string :phone_number
      t.string :website
      t.string :city
      t.string :state
      t.string :zip_code
      t.string :longitude
      t.string :latitude
      t.text :description
      t.string :name
      t.float :average_rating
      t.integer :owner_id
      t.integer :crowding_average
      t.integer :noise_average
      t.boolean :requires_purchase
      t.boolean :membership

      t.timestamps
    end
  end
end
