class LocationType < ApplicationRecord
  has_many  :work_locations, class_name: "WorkLocation", foreign_key: "location_type_id", dependent: :destroy
end
