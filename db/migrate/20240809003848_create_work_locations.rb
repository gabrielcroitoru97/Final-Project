class CreateWorkLocations < ActiveRecord::Migration[7.1]
  def change
    create_table :work_locations do |t|
      t.integer :location_type_id
      t.integer :wifi_speed
      t.string :address
      t.time :monday_opening
      t.time :tuesday_opening
      t.time :wednesday_opening
      t.time :thursday_opening
      t.time :friday_opening
      t.time :saturday_opening
      t.time :sunday_opening
      t.time :monday_closing
      t.time :tuesday_closing
      t.time :wednesday_closing
      t.time :thursday_closing
      t.time :friday_closing
      t.time :saturday_closing
      t.time :sunday_closing
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
