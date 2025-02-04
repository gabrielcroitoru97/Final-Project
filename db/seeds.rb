require 'faker'


# Cities and states
cities = [
  { city: "New York", state: "NY", zip_codes: %w[10001 10002 10003 10004 10005] },
  { city: "Los Angeles", state: "CA", zip_codes: %w[90001 90002 90003 90004 90005] },
  { city: "Chicago", state: "IL", zip_codes: %w[60601 60602 60603 60604 60605] },
  { city: "Houston", state: "TX", zip_codes: %w[77001 77002 77003 77004 77005] },
  { city: "Miami", state: "FL", zip_codes: %w[33101 33102 33103 33104 33105] }
]

default_coordinates = { latitude: 40.7128, longitude: -74.0060 } # NYC center

# Generate 40 WorkLocations
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
    weekday_opening: "#{rand(6..9)}:00 AM",
    weekday_closing: "#{rand(5..8)}:00 PM",
    weekend_opening: "#{rand(8..10)}:00 AM",
    weekend_closing: "#{rand(6..10)}:00 PM",
    location_type_id: rand(1..4),
    owner_id: rand(1..6), # Assign owner_id between 1 and 6
    latitude: coordinates[0],
    longitude: coordinates[1]
  )
end

puts "40 work locations with geocoding and owners added!"


# Seed Comments
WorkLocation.all.each do |location|
  rand(0..6).times do
    Comment.create!(
      content: Faker::Lorem.sentence(word_count: rand(5..15)),
      commenter_id: rand(1..6), # Assuming you have 6 users in your database
      location_id: location.id
    )
  end
end

puts "Comments seeded for all locations!"



# Seed Ratings
WorkLocation.all.each do |location|
  rand(0..10).times do
    Rating.create!(
      content: Faker::Lorem.sentence(word_count: rand(10..20)),
      crowding_score: rand(1..5),
      noise_level: rand(1..5),
      stars: rand(1..5),
      wifi_rating: rand(1..5),
      location_id: location.id,
      user_id: rand(1..6) # Assuming you have 6 users in your database
    )
  end
end

puts "Ratings seeded for all locations!"


User.all.each do |user|
  favorite_places = WorkLocation.pluck(:id).sample(rand(5..15)) # Select random locations for each user

  favorite_places.each do |location_id|
    FavoritePlace.create!(
      note: Faker::Lorem.sentence(word_count: rand(5..10)),
      place_id: location_id,
      user_id: user.id
    )
  end
end


WorkLocation.all.each do |location|
  # Generate between 1 to 5 images per location
  rand(1..5).times do
    image = Image.new(
      location_id: location.id,
      poster_id: rand(1..6) # Random user as poster
    )

    # Attach a random image from Lorem Picsum
    image.picture.attach(
      io: URI.open("https://picsum.photos/800/600"), # Replace with a real URL if needed
      filename: "location_#{location.id}_#{SecureRandom.hex(4)}.jpg",
      content_type: "image/jpeg"
    )

    image.save!
  end
end

puts "Images seeded for all locations!"
