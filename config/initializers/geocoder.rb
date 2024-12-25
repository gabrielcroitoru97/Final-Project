Geocoder.configure(
  # Geocoding options
  timeout: 5,                  # Geocoding request timeout (seconds)
  lookup: :google,             # Geocoding service (e.g., :google, :nominatim)
  api_key: 'AIzaSyBOmkmNEI6pvBlaQLHufHriV05FQruquog', # Replace with your actual API key
  units: :mi                   # Distance units (:km for kilometers, :mi for miles)
)
