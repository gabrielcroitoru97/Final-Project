require 'faker'

# Seed Location Types
location_types = [
  "Coffee Shop",
  "Restaurant",
  "Co-Working Space",
  "Food Court",
  "Library",
  "Park",
  "Hotel Lobby",
  "Public Plaza",
  "Museum Café",
  "Beach Lounge",
  "Community Center"
]

location_types.each do |type|
  LocationType.find_or_create_by!(descriptor: type)
end

puts "Location types seeded!"

# Cities and states
cities = [
  { city: "New York", state: "NY", zip_codes: %w[10001 10002 10003 10004 10005] },
  { city: "Los Angeles", state: "CA", zip_codes: %w[90001 90002 90003 90004 90005] },
  { city: "Chicago", state: "IL", zip_codes: %w[60601 60602 60603 60604 60605] },
  { city: "Houston", state: "TX", zip_codes: %w[77001 77002 77003 77004 77005] },
  { city: "Miami", state: "FL", zip_codes: %w[33101 33102 33103 33104 33105] }
]

default_coordinates = { latitude: 40.7128, longitude: -74.0060 } # NYC center

# Generate 40 WorkLocations with random details
40.times do
  city_data = cities.sample
  address = "#{rand(100..999)} #{['Main St', 'Broadway', 'Oak Ave', 'Maple Dr'].sample}, #{city_data[:city]}, #{city_data[:state]} #{city_data[:zip_codes].sample}"
  coordinates = Geocoder.coordinates(address) || default_coordinates.values

  WorkLocation.create!(
    name: Faker::Company.name,
    address: address,
    city: city_data[:city],
    state: city_data[:state],
    zip_code: city_data[:zip_codes].sample,
    description: Faker::Lorem.paragraph(sentence_count: 3),
    membership: [true, false].sample,
    requires_purchase: [true, false].sample,
    phone_number: Faker::PhoneNumber.phone_number.gsub(/\D/, '').slice(0, 10),
    website: Faker::Internet.url,
    monday_opening: Time.zone.parse("#{rand(6..9)}:00 AM"),
    monday_closing: Time.zone.parse("#{rand(5..8)}:00 PM"),
    tuesday_opening: Time.zone.parse("#{rand(6..9)}:00 AM"),
    tuesday_closing: Time.zone.parse("#{rand(5..8)}:00 PM"),
    wednesday_opening: Time.zone.parse("#{rand(6..9)}:00 AM"),
    wednesday_closing: Time.zone.parse("#{rand(5..8)}:00 PM"),
    thursday_opening: Time.zone.parse("#{rand(6..9)}:00 AM"),
    thursday_closing: Time.zone.parse("#{rand(5..8)}:00 PM"),
    friday_opening: Time.zone.parse("#{rand(6..9)}:00 AM"),
    friday_closing: Time.zone.parse("#{rand(5..8)}:00 PM"),
    saturday_opening: Time.zone.parse("#{rand(8..10)}:00 AM"),
    saturday_closing: Time.zone.parse("#{rand(6..10)}:00 PM"),
    sunday_opening: Time.zone.parse("#{rand(8..10)}:00 AM"),
    sunday_closing: Time.zone.parse("#{rand(6..10)}:00 PM"),
    location_type_id: LocationType.pluck(:id).sample, # Randomly assign a location type
    owner_id: User.pluck(:id).sample, # Assign an existing owner ID
    latitude: coordinates[0],
    longitude: coordinates[1]
  )
end

puts "40 work locations with opening and closing times added!"

# Seed Comments
WorkLocation.find_each do |location|
  rand(0..6).times do
    Comment.create!(
      content: Faker::Lorem.sentence(word_count: rand(5..15)),
      commenter_id: User.pluck(:id).sample,
      location_id: location.id
    )
  end
end

puts "Comments seeded for all locations!"

# Seed Ratings
WorkLocation.find_each do |location|
  rand(0..10).times do
    Rating.create!(
      content: Faker::Lorem.sentence(word_count: rand(10..20)),
      crowding_score: rand(1..5),
      noise_level: rand(1..5),
      stars: rand(1..5),
      wifi_rating: rand(1..5),
      location_id: location.id,
      user_id: User.pluck(:id).sample
    )
  end
end

puts "Ratings seeded for all locations!"

# Seed FavoritePlaces
User.find_each do |user|
  favorite_places = WorkLocation.pluck(:id).sample(rand(5..15))
  favorite_places.each do |location_id|
    FavoritePlace.create!(
      note: Faker::Lorem.sentence(word_count: rand(5..10)),
      place_id: location_id,
      user_id: user.id
    )
  end
end

puts "Favorite places seeded for users!"

# Seed Images
WorkLocation.find_each do |location|
  rand(1..5).times do
    image = Image.new(
      location_id: location.id,
      poster_id: User.pluck(:id).sample
    )

    # Attach a random image from Lorem Picsum
    begin
      image.picture.attach(
        io: URI.open("https://picsum.photos/800/600"),
        filename: "location_#{location.id}_#{SecureRandom.hex(4)}.jpg",
        content_type: "image/jpeg"
      )
      image.save!
    rescue => e
      puts "Error attaching image: #{e.message}"
    end
  end
end

puts "Images seeded for all locations!"
