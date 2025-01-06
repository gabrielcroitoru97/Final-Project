
WorkLocation.find_each do |location|
  # Randomly decide whether to update this location (80% chance)
  next unless rand < 0.8

  # Random realistic opening and closing times
  opening_times = ["08:00", "09:00", "10:00"]
  closing_times = ["17:00", "18:00", "19:00"]

  days = %w[monday tuesday wednesday thursday friday saturday sunday]
  
  days.each do |day|
    location["#{day}_opening"] = opening_times.sample
    location["#{day}_closing"] = closing_times.sample
  end

  location.save!
end
