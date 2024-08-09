# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_08_09_005051) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.integer "commenter_id"
    t.integer "location_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "favorite_places", force: :cascade do |t|
    t.integer "user_id"
    t.integer "place_id"
    t.string "note"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "images", force: :cascade do |t|
    t.integer "location_id"
    t.integer "poster_id"
    t.string "picture"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "location_types", force: :cascade do |t|
    t.string "descriptor"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ratings", force: :cascade do |t|
    t.integer "user_id"
    t.integer "location_id"
    t.integer "stars"
    t.text "content"
    t.integer "wifi_rating"
    t.integer "crowding_score"
    t.integer "noise_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "work_locations", force: :cascade do |t|
    t.integer "location_type_id"
    t.integer "wifi_speed"
    t.string "address"
    t.time "weekday_opening"
    t.time "weekend_opening"
    t.time "weekday_closing"
    t.time "weekend_closing"
    t.string "phone_number"
    t.string "website"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "longitude"
    t.string "latitude"
    t.text "description"
    t.string "name"
    t.float "average_rating"
    t.integer "owner_id"
    t.integer "crowding_average"
    t.integer "noise_average"
    t.boolean "requires_purchase"
    t.boolean "membership"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
