namespace :work_locations do
  desc "Update crowding and noise averages for all work locations"
  task update_averages: :environment do
    WorkLocation.find_each do |location|
      crowding_average = location.ratings.average(:crowding_score)&.round || 0
      noise_average = location.ratings.average(:noise_level)&.round || 0
      wifi_speed = location.ratings.average(:wifi_rating)&.round || 0
      average_rating = location.ratings.average(:stars)&.round || 0

      location.update_columns(
        crowding_average: crowding_average,
        noise_average: noise_average,
        wifi_speed: wifi_speed,
        average_rating: average_rating
      )
      puts "Updated averages for location: #{location.name}"
    end
  end
end
