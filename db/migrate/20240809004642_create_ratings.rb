class CreateRatings < ActiveRecord::Migration[7.1]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :location_id
      t.integer :stars
      t.text :content
      t.integer :wifi_rating
      t.integer :crowding_score
      t.integer :noise_level

      t.timestamps
    end
  end
end
