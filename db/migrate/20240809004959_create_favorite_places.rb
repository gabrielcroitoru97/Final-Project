class CreateFavoritePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :favorite_places do |t|
      t.integer :user_id
      t.integer :place_id
      t.string :note

      t.timestamps
    end
  end
end
