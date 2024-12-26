namespace :geocode do
  desc "Geocode all work locations without latitude and longitude"
  task work_locations: :environment do
    WorkLocation.where(latitude: nil, longitude: nil).find_each do |work_location|
      begin
        work_location.geocode
        if work_location.latitude.present? && work_location.longitude.present?
          work_location.save!
          puts "Geocoded: #{work_location.full_address} -> [#{work_location.latitude}, #{work_location.longitude}]"
        else
          puts "Failed to geocode: #{work_location.full_address}"
        end
      rescue StandardError => e
        puts "Error geocoding #{work_location.id}: #{e.message}"
      end
    end
  end
end
